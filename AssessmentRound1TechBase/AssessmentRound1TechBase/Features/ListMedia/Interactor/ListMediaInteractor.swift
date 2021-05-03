//
//  ListMediaInteractorImp.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 30/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class ListMediaInteractorImp: BaseInteractor {
    
    var insets: BasePresenter.Insets = BasePresenter.Insets(top: 10, left: 10, bottom: 10, right: 10)
    var isFetching: Bool = false
    let pendingOperations: PendingOperations = PendingOperations()
    var modeDisplay: ModeDisplay = .regular
    var completionFetchData: ((Bool) -> Void)?
    private var dataSource: [BaseModel] = []

    func inject(insets: BasePresenter.Insets,
                modeDisplay: ModeDisplay) {
        self.modeDisplay = modeDisplay
        self.insets = insets
    }
    
    private func updateStateFetching(value: Bool) {
        isFetching = value
        completionFetchData?(value)
    }
  
}

extension ListMediaInteractorImp: ListMediaInteractor {
    
    func suspendAllOperations() {
        pendingOperations.downloadQueue.isSuspended = true
        pendingOperations.filtrationQueue.isSuspended = true
    }
    
    func clearDownloadOperations() {
        pendingOperations.downloadsInProgress.removeAll()
        pendingOperations.filtrationsInProgress.removeAll()
    }
    
    func resumeAllOperations() {
        pendingOperations.downloadQueue.isSuspended = false
        pendingOperations.filtrationQueue.isSuspended = false
    }

    func startOperations(for media: MediaModel,
                         indexPath: IndexPath,
                         completion: @escaping ([IndexPath]) -> Void) {
        switch media.getStateImage() {
        case .new:
            startDownload(for: media,
                          indexPath: indexPath,
                          completion: completion)
        case .downloaded:
            startFiltration(for: media,
                            indexPath: indexPath,
                            completion: completion)
        default:
            break
        }
    }
    
    func loadImages(for keys: [IndexPath], completion: @escaping ([IndexPath]) -> Void) {
        var allPendingOperations = Set(Array(pendingOperations.downloadsInProgress.keys))
        allPendingOperations.formUnion(Set(Array(pendingOperations.filtrationsInProgress.keys)))
        
        var toBeCancelled = allPendingOperations
        let visiblePaths = Set(keys)
        toBeCancelled.subtract(visiblePaths as Set<IndexPath>)

        var toBeStarted = visiblePaths
        toBeStarted.subtract(allPendingOperations as Set<IndexPath>)
        
        toBeCancelled.forEach { (indexPath) in
            if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
                pendingDownload.cancel()
            }
            pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            
            if let pendingFiltration = pendingOperations.filtrationsInProgress[indexPath] {
                pendingFiltration.cancel()
            }
            pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
        }
        
        toBeStarted.forEach { (indexPath) in
            let indexPath = indexPath
            guard let recordToProcess = getDataSource()[safe: indexPath.row] as? MediaModel else { return }
            self.startOperations(for: recordToProcess,
                                       indexPath: indexPath,
                                       completion: { (indexPaths) in
                                        completion(indexPaths)
            })
        }
    }
    
    func startFiltration(for media: MediaModel, indexPath: IndexPath, completion: @escaping ([IndexPath]) -> Void) {
        guard pendingOperations.filtrationsInProgress[indexPath] == nil else { return }
        let filterer = ImageFiltration(media)
        
        filterer.completionBlock = {
            if filterer.isCancelled { return }
            
            DispatchQueue.main.async {
                self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                completion([indexPath])
            }
        }
        
        pendingOperations.filtrationsInProgress[indexPath] = filterer
        pendingOperations.filtrationQueue.addOperation(filterer)
    }
    
    func startDownload(for media: MediaModel, indexPath: IndexPath, completion: @escaping ([IndexPath]) -> Void) {
        guard pendingOperations.downloadsInProgress[indexPath] == nil else { return }
        let downloader = ImageDownloader(media)
        
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                completion([indexPath])
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    func fetchData(currentPage: Int, limit: Int, completion: @escaping ([IndexPath]) -> Void) {
        updateStateFetching(value: true)
        MediaService.share.fetchData(page: currentPage, limit: limit) { [weak self] (res) in
            
            guard let self = self else { return }
            
            self.updateStateFetching(value: false)
            
            switch res.result {
            case .success(let data):
                guard let arr = data.array?.compactMap({ MediaModel(json: $0)}) else { return }
                
                var paths: [IndexPath] = []
                
                arr.enumerated().forEach { (index, item) in
                    let indexPath = IndexPath(item: index + self.dataSource.count, section: 0)
                    paths.append(indexPath)
                }
                self.dataSource.append(contentsOf: arr)
                
                self.dataSource.append(NoteModel())
                paths.append(IndexPath(item: self.dataSource.count - 1, section: 0))
                
                completion(paths)
            case .failure:
                completion([])
            }
        }
    }
    
    func clearDataSource() {
        dataSource.removeAll()
    }
    
    func getDataSource() -> [BaseModel] {
        return dataSource
    }
    
    func getDataModel() -> [BaseModel] {
        return dataSource
    }
    
    func setDataModel(_ models: [BaseModel]) {
        self.dataSource = models
    }
    
    func getTypeDisplay() -> ModeDisplay {
        return modeDisplay
    }
    
    func setTypeDisplay(_ type: ModeDisplay) {
        self.modeDisplay = type
    }
    
}
