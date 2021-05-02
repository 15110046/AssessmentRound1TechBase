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
    var subscribeStateLoading: ((Bool) -> Void)? = nil
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
        case .Regular:
            return (interactor?.modeDisplay.column ?? 1) - 1
        case .Compact:
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
                        completion: @escaping ([IndexPath]) -> ()) {
        interactor?.startOperations(for: media,
                                    indexPath: indexPath,
                                    completion: completion)
    }
        
    func loadImagesForOnscreenCells(at indexPathsForVisible: [IndexPath],
                                    completion: @escaping ([IndexPath]) -> ()) {
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
        return interactor?.modeDisplay ?? ModeDisplay.Regular
    }
    
    func getInset() -> (top: Float, left: Float, bottom: Float, right: Float) {
        return interactor?.insets ?? (0, 0, 0, 0)
    }
    
    func collectionViewIsFetchingData() -> Bool {
        return interactor?.isFetching ?? false
    }
    
    func refreshData() {
        currentPage = 1
        stopRequestFetching = false
        interactor?.clearDataSource()
    }

    func refreshData(completion: @escaping () -> ()) {
        currentPage = 1
        stopRequestFetching = false
        interactor?.clearDataSource()
        completion()
    }

    func requestFetchData(completion: @escaping (Response<[IndexPath]>)->()) {
        if !networkIsWork {
            completion(.init(status: .failure(Constants.ErrorNetwork)))
            return
        }
        
        interactor?.fetchData(currentPage: currentPage, limit: limitItemInBlock, completion: { [weak self] (indexPaths) in
            if indexPaths.count > 0 {
                self?.currentPage += 1
                completion(.init(status: .success(indexPaths)))
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
            return MediaCollectionViewCellPresenter(modeDisplay: interactor?.modeDisplay ?? ModeDisplay.Regular, dataModel: mediaModel)
        case let noteModel as NoteModel:
            return NoteCollectionViewCellPresenter(modeDisplay: interactor?.modeDisplay ?? ModeDisplay.Regular, dataModel: noteModel)
        default:
            return nil
        }
    }

}
