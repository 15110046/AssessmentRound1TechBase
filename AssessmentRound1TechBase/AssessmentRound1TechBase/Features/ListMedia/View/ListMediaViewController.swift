//
//  ListMediaViewController.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit
import Alamofire_SwiftyJSON

class ListMediaViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView:      UICollectionView?
    @IBOutlet private weak var segmentView:         SegmentView?
    @IBOutlet private weak var bottomLoadingView:   BottomLoadingView?
    
    weak var delegate:                    ListMediaDelegate? = nil
    private var presenter:                ListMediaPresenter?
    private var collectionViewDataSource: ListMediaCollectionViewDataSource?
    private var collectionViewDelegate:   ListMediaCollectionViewDelegate?

    func inject(presenter: ListMediaPresenter) {
        self.presenter = presenter
    }
    
    func getCollectionView() -> UICollectionView? {
        return collectionView
    }
    
    func getSegmentView() -> SegmentView? {
        return segmentView
    }
    
    func getBottomLoadingView() -> BottomLoadingView? {
        return bottomLoadingView
    }
        
    private var refreshControl: UIRefreshControl {
        let _refreshControl = UIRefreshControl()
        _refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return _refreshControl
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presenter?.clearCacheSize()
        self.collectionView?.reloadData()
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.clearAllOperationsLoadMedia()
        refreshData {
            refreshControl.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewIsReady()
        firstLoad()
    }
    
    private func firstLoad() {
        refreshData()
    }
    
    func refreshData(completion: (() -> Void)? = nil) {
        presenter?.refreshData { [weak self] in
            guard let self = self else { return }
            self.collectionView?.reloadData()
            self.presenter?.requestFetchData { (result) in
                switch result.status {
                case .failure(let error):
                    self.showAlert(title: Constants.NotifiNameDefault, message: error)
                case .success:
                    self.collectionView?.reloadData()
                }
                completion?()
            }
        }
    }
    
    private func viewIsReady() {
        setUpCollectionView()
        setUpSegmentView()
        setUpLoadingBottomView()
    }
    
    private func setUpLoadingBottomView() {
        bottomLoadingView?.isHidden = true
        presenter?.subscribeStateLoading = { [weak self] isShow in
            self?.bottomLoadingView?.setHidden(!isShow)
        }
    }
    
    private func setUpSegmentView() {
        segmentView?.delegate = self
        segmentView?.configSegment(items: presenter?.getModeDisplay().getAllMode() ?? []
            , selectedMode: presenter?.getModeDisplay() ?? ModeDisplay.Compact)
    }
    
    private func setUpCollectionView() {
        guard let collectionViewLayout = presenter?.getCollectionViewFlowLayout() as? UICollectionViewFlowLayout else { return }
        
        presenter?.getNameCellsWillregister().forEach({ cellName in
            collectionView?.register(UINib(nibName: cellName,
                                           bundle:  nil),
                                     forCellWithReuseIdentifier: cellName)
        })
        collectionView?.collectionViewLayout = collectionViewLayout
        collectionView?.contentInset         = UIEdgeInsets(
                                                   top: CGFloat(presenter?.getInset().top ?? 0),
                                                   left: CGFloat(presenter?.getInset().left ?? 0),
                                                   bottom: CGFloat(presenter?.getInset().bottom ?? 0),
                                                   right: CGFloat(presenter?.getInset().right ?? 0))
        collectionView?.refreshControl       = refreshControl
        collectionViewDataSource             = ListMediaCollectionViewDataSource(presenter: presenter)
        collectionViewDelegate               = ListMediaCollectionViewDelegate(presenter: presenter)
        collectionView?.delegate             = collectionViewDelegate
        collectionView?.dataSource           = collectionViewDataSource
    }
    
}

extension ListMediaViewController: SegmentViewDelegate {
    func segmentViewchangeMode(at mode: ModeDisplay) {
        presenter?.setModeDisplay(mode: mode)
        KeyChain.saveSegment(key: mode.name)
        presenter?.clearCacheSize()
        guard let indexPaths = collectionView?.indexPathsForVisibleItems else { return }
        self.collectionView?.performBatchUpdates({
            self.collectionView?.reloadSafeItems(at: indexPaths)
        }, completion: nil)
    }
}
