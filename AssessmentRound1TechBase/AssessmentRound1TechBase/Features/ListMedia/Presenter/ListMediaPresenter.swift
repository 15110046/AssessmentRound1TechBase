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
    var subscribeStateLoading: ((Bool) -> Void)?
    var stopRequestFetching: Bool = false
    
    func inject(interactor: ListMediaInteractor?, router: ListMediaRouter?) {  
        self.interactor = interactor
        self.router = router
        interactor?.completionFetchData = { [weak self] value in
            self?.subscribeStateLoading?(value)
        }
    }
    
}

extension ListMediaPresenterImp: ListMediaPresenter {
    
    func clearCacheSize() {
        interactor?.getDataSource().forEach({ (model) in
            model.clearSize()
        })
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
    
    func resumeAllOperationsLoadMedia() {
        interactor?.resumeAllOperations()
    }
    
    func clearAllOperationsLoadMedia() {
        interactor?.clearDownloadOperations()
    }
    
    func suspendAllOperationsLoadMedia() {
        interactor?.suspendAllOperations()
    }
    
    func setModeDisplay(mode: ModeDisplay) {
        interactor?.modeDisplay = mode
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
    
    func collectionViewIsFetchingData() -> Bool {
        return interactor?.isFetching ?? false
    }
    
    func refreshData() {
        currentPage = 1
        stopRequestFetching = false
        interactor?.clearDataSource()
    }

    func refreshData(completion: @escaping () -> Void) {
        currentPage = 1
        stopRequestFetching = false
        interactor?.clearDataSource()
        completion()
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
    
    func getNumberOfItemsInSection() -> Int {
        return interactor?.getDataSource().count ?? 0
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

}
