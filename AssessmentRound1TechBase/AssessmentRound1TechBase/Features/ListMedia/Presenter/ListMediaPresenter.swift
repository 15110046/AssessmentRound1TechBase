//
//  ListMediaPresenter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class ListMediaPresenterImp: BasePresenter {
    
    private var interactor: ListMediaInteractor?
    private weak var router: ListMediaRouter?
    
    private var currentPage: Int = 1
    let limitItemInBlock: Int = Constants.LimitItemInBlock
    private var stopRequestFetching: Bool = false
    
    func inject(interactor: ListMediaInteractor?, router: ListMediaRouter?) {  
        self.interactor = interactor
        self.router = router
    }
    
    func collectionViewIsFetchingData() -> Bool {
        return interactor?.isFetching ?? false
    }
    
    func requestFetchData(completion: @escaping ([IndexPath]) -> Void) {
        if !networkIsWork {
            router?.showToast(title: Constants.NotifiNameDefault, message: Constants.ErrorNetwork)
            return
        }
        
        interactor?.fetchData(currentPage: currentPage, limit: limitItemInBlock, completion: { [weak self] (indexPaths) in
            if !indexPaths.isEmpty {
                self?.currentPage += 1
                completion(indexPaths)
            } else {
                self?.stopRequestFetching = true
            }
        })
    }
    
    func presenterForCell(at index: Int) -> BaseCellPresenter? {
        guard let dataModel = interactor?.getDataSource()[safe: index] else {
            return nil
        }
        switch dataModel {
        case let mediaModel as MediaModel:
            return MediaCollectionViewCellPresenter(modeDisplay: interactor?.modeDisplay ?? ModeDisplay.regular, dataModel: mediaModel)
        case let noteModel as NoteModel:
            return NoteCollectionViewCellPresenter(modeDisplay: interactor?.modeDisplay ?? ModeDisplay.regular, dataModel: noteModel)
        default:
            return nil
        }
    }

    func getColumnInteritem(model: BaseModel) -> Int {
        switch interactor?.modeDisplay {
        case .regular:
            return (interactor?.modeDisplay.column ?? 1) - 1
        case .compact:
            switch model {
            case is MediaModel:
                return (interactor?.modeDisplay.column ?? 1) - 1
            case is NoteModel:
                let surplus: Int = Constants.LimitItemInBlock % (interactor?.modeDisplay.column ?? 1)
                return surplus
            default:
                return 0
            }
        case .none:
            return 0
        }
    }

    func clearCacheSize() {
        interactor?.getDataSource().forEach({ (model) in
            model.clearSize()
        })
    }
    
    func clearAllOperationsLoadMedia() {
        interactor?.clearDownloadOperations()
    }
    
    func resumeAllOperationsLoadMedia() {
        interactor?.resumeAllOperations()
    }
    
    func suspendAllOperationsLoadMedia() {
        interactor?.suspendAllOperations()
    }

}

// MARK: ListMediaDataSourcePresenter
extension ListMediaPresenterImp: ListMediaDataSourcePresenter {
    
    func getNumberOfItemsInSection() -> Int {
        return interactor?.getDataSource().count ?? 0
    }
    
    func cellForItemAt(indexPath: IndexPath, delegate: ListMediaViewDelegate) -> CellViewInterface? {
        guard
            let presenterCell = presenterForCell(at: indexPath.item),
            let cell = delegate.collectionViewDequequeCell(cellName: presenterCell.getCellName(), indexPath: indexPath) as? CellViewInterface else { return nil }
        
        cell.loadCell(presenterCell)
        
        guard let modelModel = getDataSource()[safe: indexPath.item] as? MediaModel else { return cell }
        
        startLoadMedia(for: modelModel, indexPath: indexPath, completion: { (indexPaths) in
            delegate.collectionViewReloadItems(at: indexPaths)
        })
        
        return cell
    }
}

// MARK: ListMediaDelegatePresenter
extension ListMediaPresenterImp: ListMediaDelegatePresenter {
    
    func collectionViewScroll(decelerate: Bool, indexPathsVisible: [IndexPath], delegate: ListMediaViewDelegate) {
        guard !decelerate else { return }
        loadImagesForOnscreenCells(at: indexPathsVisible) { indexPaths in
            delegate.collectionViewReloadItems(at: indexPaths)
        }
        resumeAllOperationsLoadMedia()
    }
    
    func collectionViewDidEndDecelerating(indexPathsVisible: [IndexPath], delegate: ListMediaViewDelegate) {
        loadImagesForOnscreenCells(at: indexPathsVisible) { indexPaths in
            delegate.collectionViewReloadItems(at: indexPaths)
        }
        resumeAllOperationsLoadMedia()
    }
    
    func collectionViewWillDisplay(forItemAt indexPath: IndexPath, delegate: ListMediaViewDelegate) {
        if
            indexPath.item >= getDataSource().count - 1,
            !collectionViewIsFetchingData(),
            !stopRequestFetching {
            
            requestFetchData { (indexPaths) in
                delegate.collectionViewInsertItems(at: indexPaths)
            }
        }

    }
    
    func getWidthAfterSubInset(at indexPath: IndexPath, maxWidth: CGFloat, minimumInteritemSpacing: CGFloat) -> CGFloat {
        guard let model = getDataSource()[safe: indexPath.item] else { return 0 }
        let safePixel: CGFloat = 0.5
        let columnInteritem = CGFloat(getColumnInteritem(model: model))
        return maxWidth - minimumInteritemSpacing*columnInteritem - safePixel
    }
    
    func collectionViewSizeForItem(maxWidth: CGFloat, at indexPath: IndexPath) -> CGSize {
        guard let presenterCell = presenterForCell(at: indexPath.item) else {
                return CGSize.zero
        }
        
        let width = presenterCell.getCellWidth(maxWidth: maxWidth)
        let height = presenterCell.getCellHeight(maxWidth: maxWidth)
        return CGSize(width: width, height: height).getSizeSafePixcel()
    }
    
}

// MARK: ListMediaPresenter
extension ListMediaPresenterImp: ListMediaPresenter {
        
    func deviceWillTransition(delegate: ListMediaViewDelegate) {
        clearCacheSize()
        delegate.collectionViewReloadData()
    }
        
    func startLoadMedia(for media: MediaModel,
                        indexPath: IndexPath,
                        completion: @escaping ([IndexPath]) -> Void) {
        switch media.getStateImage() {
        case .new:
            interactor?.startDownload(for: media, indexPath: indexPath, completion: { [weak self] _ in
                self?.interactor?.startFiltration(for: media, indexPath: indexPath, completion: completion)
            })
        case .downloaded:
            interactor?.startFiltration(for: media, indexPath: indexPath, completion: completion)
        case .filtered: break
        case .failed: break
        }
    }
        
    func loadImagesForOnscreenCells(at indexPathsForVisible: [IndexPath],
                                    completion: @escaping ([IndexPath]) -> Void) {
        interactor?.loadImages(for: indexPathsForVisible,
                               completion: completion)
    }
    
    func startSubscribeLoadingView(delegate: ListMediaViewDelegate) {
        interactor?.completionFetchData = { value in
            delegate.bottomViewSetHidden(!value)
        }
    }
    
    func setModeDisplay(mode: ModeDisplay, delegate: ListMediaViewDelegate, indexPathsVisible: [IndexPath]?) {
        interactor?.setModeDisplay(type: mode, saveToLocal: true)
        clearCacheSize()
        guard let indexPaths = indexPathsVisible else {
            delegate.collectionViewReloadData()
            return
        }
        delegate.collectionViewReloadItems(at: indexPaths)
    }

    func getModeDisplay() -> ModeDisplay {
        return interactor?.modeDisplay ?? ModeDisplay.regular
    }
    
    func getInset() -> BasePresenter.Insets {
        return interactor?.insets ?? BasePresenter.Insets(top: 0,
                                                          left: 0,
                                                          bottom: 0,
                                                          right: 0)
    }
    
    func refreshData(delegate: ListMediaViewDelegate) {
        clearAllOperationsLoadMedia()
        clearCacheSize()
        currentPage = 1
        stopRequestFetching = false
        interactor?.clearDataSource()
        delegate.collectionViewReloadData()
        requestFetchData { _ in
            delegate.collectionViewReloadData()
        }
    }
    
    func getDataSource() -> [BaseModel] {
        return interactor?.getDataSource() ?? []
    }
    
    func getNameCellsWillregister() -> [String] {
        return [Constants.Cells.NoteCollectionViewCell,
                Constants.Cells.MediaVerticalCollectionViewCell,
                Constants.Cells.MediaHorizontalCollectionViewCell]
    }
    
    func getCollectionViewFlowLayout() -> NSObject {
        return LeftAlignedCollectionViewFlowLayout(minimumLineSpacing: 10,
                                                   minimumInteritemSpacing: 10)
    }
    
}
