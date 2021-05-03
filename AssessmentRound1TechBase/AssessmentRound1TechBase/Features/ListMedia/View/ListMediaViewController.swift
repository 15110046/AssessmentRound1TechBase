//
//  ListMediaViewController.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

class ListMediaViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var segmentView: SegmentView?
    @IBOutlet private weak var bottomLoadingView: BottomLoadingView?
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }
    
    private var presenter: ListMediaPresenter?
    private var collectionViewDataSource: ListMediaCollectionViewDataSource?
    private var collectionViewDelegate: ListMediaCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewIsReady()
        firstLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presenter?.deviceWillTransition(delegate: self)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        refreshData()
    }
    
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
    
    private func firstLoad() {
        refreshData()
    }
    
    func refreshData() {
        presenter?.refreshData(delegate: self)
    }
    
    private func viewIsReady() {
        setUpCollectionView()
        setUpSegmentView()
        setUpLoadingBottomView()
    }
    
    private func setUpLoadingBottomView() {
        presenter?.startSubscribeLoadingView(delegate: self)
    }
    
    private func setUpSegmentView() {
        segmentView?.delegate = self
        segmentView?.configSegment(
            items: presenter?.getModeDisplay().getAllMode() ?? [],
            selectedMode: presenter?.getModeDisplay() ?? ModeDisplay.compact)
    }
    
    private func setUpCollectionView() {
        guard let collectionViewLayout = presenter?.getCollectionViewFlowLayout() as? UICollectionViewFlowLayout else { return }
        
        presenter?.getNameCellsWillregister().forEach({ cellName in
            collectionView?.register(UINib(nibName: cellName,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: cellName)
        })
        collectionView?.collectionViewLayout = collectionViewLayout
        collectionView?.contentInset         = UIEdgeInsets(
            top: CGFloat(presenter?.getInset().top ?? 0),
            left: CGFloat(presenter?.getInset().left ?? 0),
            bottom: CGFloat(presenter?.getInset().bottom ?? 0),
            right: CGFloat(presenter?.getInset().right ?? 0))
        collectionView?.refreshControl       = refreshControl
        collectionViewDataSource             = ListMediaCollectionViewDataSource(presenter: presenter, delegate: self)
        collectionViewDelegate               = ListMediaCollectionViewDelegate(presenter: presenter, delegate: self)
        collectionView?.delegate             = collectionViewDelegate
        collectionView?.dataSource           = collectionViewDataSource
    }
    
}

// MARK: SegmentViewDelegate
extension ListMediaViewController: SegmentViewDelegate {
    func segmentViewchangeMode(at mode: ModeDisplay) {
        presenter?.setModeDisplay(mode: mode, delegate: self, indexPathsVisible: collectionView?.indexPathsForVisibleItems)
    }
}

// MARK: Outside -> View
extension ListMediaViewController: ListMediaViewDelegate {
    func collectionViewInsertItems(at indexPaths: [IndexPath]) {
        collectionView?.insetSafeItems(at: indexPaths)
    }
    
    func collectionViewDequequeCell(cellName: String, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView?.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionViewReloadData() {
        collectionView?.reloadData()
    }
    
    func collectionViewReloadItems(at indexPaths: [IndexPath]) {
        self.collectionView?.performBatchUpdates({ [weak self] in
            self?.collectionView?.reloadSafeItems(at: indexPaths)
            }, completion: nil)
    }
    
    func bottomViewSetHidden(_ isHidden: Bool) {
        bottomLoadingView?.setHidden(isHidden)
    }
    
}
