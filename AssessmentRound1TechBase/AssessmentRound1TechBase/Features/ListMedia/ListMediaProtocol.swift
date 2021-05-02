//
//  ListMediaProtocol.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

protocol ListMediaDelegate: class {
    
}

protocol ListMediaPresenter: ListMediaDataSourcePresenter, ListMediaDelegatePresenter {
    var subscribeStateLoading: ((Bool) -> Void)? { get set }
    func getNameCellsWillregister() -> [String]
    func getCollectionViewFlowLayout() -> NSObject
    func refreshData(completion: @escaping ()->())
    func refreshData()
    func getInset() -> (top: Float, left: Float, bottom: Float, right: Float)
    func clearCacheSize()
    func clearAllOperationsLoadMedia()
}

protocol ListMediaDataSourcePresenter: ListMediaOperationPresenter {
    func getNumberOfItemsInSection() -> Int
    func getDataSource() -> [BaseModel]
    func getModeDisplay() -> ModeDisplay
    func presenterForCell(at index: Int) -> BaseCellPresenter?
}

protocol ListMediaDelegatePresenter: ListMediaOperationPresenter {
    func getDataSource() -> [BaseModel]
    func getModeDisplay() -> ModeDisplay
    func setModeDisplay(mode: ModeDisplay)
    func collectionViewIsFetchingData() -> Bool
    func requestFetchData(completion: @escaping (Response<[IndexPath]>)->())
    func presenterForCell(at index: Int) -> BaseCellPresenter?
    func getColumnInteritem(model: BaseModel) -> Int
}

protocol ListMediaOperationPresenter: class {
    var stopRequestFetching: Bool { get set }
    func startLoadMedia(for media: MediaModel, indexPath: IndexPath, completion: @escaping ([IndexPath])->())
    func loadImagesForOnscreenCells(at indexPathsForVisible: [IndexPath], completion: @escaping ([IndexPath])->())
    func resumeAllOperationsLoadMedia()
    func suspendAllOperationsLoadMedia()
}

protocol ListMediaInteractor: class {
    var completionFetchData: ((Bool) -> ())? { get set }
    var isFetching: Bool { get set }
    var modeDisplay: ModeDisplay { get set }
    var insets: (top: Float, left: Float, bottom: Float, right: Float) { get set }
    
    func getDataSource() -> [BaseModel]
    func fetchData(currentPage: Int, limit: Int, completion: @escaping ([IndexPath])->()) 
    func clearDataSource()
    
    //OperationLoad Image
    func clearDownloadOperations()
    func loadImages(for keys: [IndexPath], completion: @escaping ([IndexPath]) -> ())
    func startFiltration(for media: MediaModel,
                         indexPath: IndexPath,
                         completion: @escaping ([IndexPath])->())
    func startDownload(for media: MediaModel,
                       indexPath: IndexPath,
                       completion: @escaping ([IndexPath])->())
    func startOperations(for media: MediaModel,
                         indexPath: IndexPath,
                         completion: @escaping ([IndexPath]) -> ()) 
    func suspendAllOperations()
    func resumeAllOperations()
}

protocol ListMediaRouter: class {
    
}

extension ListMediaViewController {
    
    static func create(modeDisplay: ModeDisplay,
                                  set delegate: Any?) -> UIViewController {
        let vc = ListMediaViewController()
        vc.delegate = delegate as? ListMediaDelegate
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        let router = vc
        interactor.inject(insets: (top: 10, left: 10, bottom: 10, right: 10), modeDisplay: KeyChain.loadSegment())
        presenter.inject(interactor: interactor, router: router)
        vc.inject(presenter: presenter)
        return vc
    }
}


