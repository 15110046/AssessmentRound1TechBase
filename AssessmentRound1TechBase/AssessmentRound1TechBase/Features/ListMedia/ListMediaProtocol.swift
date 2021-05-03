//
//  ListMediaProtocol.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

protocol ListMediaViewDelegate: class {
    func collectionViewReloadData()
    func collectionViewReloadItems(at indexPaths: [IndexPath])
    func collectionViewInsertItems(at indexPaths: [IndexPath])
    func bottomViewSetHidden(_ isHidden: Bool)
    func collectionViewDequequeCell(cellName: String, indexPath: IndexPath) -> UICollectionViewCell
}

protocol ListMediaPresenter: ListMediaDataSourcePresenter, ListMediaDelegatePresenter {
    func startSubscribeLoadingView(delegate: ListMediaViewDelegate)
    func getNameCellsWillregister() -> [String]
    func getCollectionViewFlowLayout() -> NSObject
    func refreshData(delegate: ListMediaViewDelegate)
    func getInset() -> BasePresenter.Insets
    func setModeDisplay(mode: ModeDisplay, delegate: ListMediaViewDelegate, indexPathsVisible: [IndexPath]?)
    func deviceWillTransition(delegate: ListMediaViewDelegate)
    func getModeDisplay() -> ModeDisplay
}

protocol ListMediaDataSourcePresenter: class {
    func getNumberOfItemsInSection() -> Int
    func cellForItemAt(indexPath: IndexPath, delegate: ListMediaViewDelegate) -> CellViewInterface?
}

protocol ListMediaDelegatePresenter: ListMediaOperationPresenter {
    func collectionViewScroll(decelerate: Bool, indexPathsVisible: [IndexPath], delegate: ListMediaViewDelegate)
    func collectionViewDidEndDecelerating(indexPathsVisible: [IndexPath], delegate: ListMediaViewDelegate)
    func collectionViewWillDisplay(forItemAt indexPath: IndexPath, delegate: ListMediaViewDelegate)
    func getWidthAfterSubInset(at indexPath: IndexPath,
                               maxWidth: CGFloat,
                               minimumInteritemSpacing: CGFloat) -> CGFloat
    func collectionViewSizeForItem(maxWidth: CGFloat, at indexPath: IndexPath) -> CGSize
}

protocol ListMediaOperationPresenter: class {
    func loadImagesForOnscreenCells(at indexPathsForVisible: [IndexPath], completion: @escaping ([IndexPath]) -> Void)
    func resumeAllOperationsLoadMedia()
    func suspendAllOperationsLoadMedia()
}

protocol ListMediaInteractor: class {
    var completionFetchData: ((Bool) -> Void)? { get set }
    var isFetching: Bool { get }
    var modeDisplay: ModeDisplay { get }
    var insets: BasePresenter.Insets { get }
    
    func setModeDisplay(type: ModeDisplay, saveToLocal: Bool)
    func getDataSource() -> [BaseModel]
    func fetchData(currentPage: Int, limit: Int, completion: @escaping ([IndexPath]) -> Void)
    func clearDataSource()
    func clearDownloadOperations()
    func loadImages(for keys: [IndexPath], completion: @escaping ([IndexPath]) -> Void)
    func startFiltration(for media: MediaModel,
                         indexPath: IndexPath,
                         completion: @escaping ([IndexPath]) -> Void)
    func startDownload(for media: MediaModel,
                       indexPath: IndexPath,
                       completion: @escaping ([IndexPath]) -> Void)
    func suspendAllOperations()
    func resumeAllOperations()
}

protocol ListMediaRouter: class {
    func showToast(title: String, message: String)
}

extension ListMediaViewController {
    
    static func create() -> UIViewController {
        
        let vc = ListMediaViewController()
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        let router = vc

        interactor.inject(insets: BasePresenter.Insets(top: 10, left: 10, bottom: 10, right: 10))
        presenter.inject(interactor: interactor, router: router)
        vc.inject(presenter: presenter)
        return vc
    }
}
