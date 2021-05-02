//
//  ListMediaPresenterTest.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class ListMediaPresenterTest: XCTestCase {
    var vc: ListMediaViewController?

    override func setUp() {
        vc = ListMediaViewController.create(modeDisplay: .Compact, set: nil) as? ListMediaViewController
        vc?.loadViewIfNeeded()
        vc?.viewDidLoad()
    }

    override func tearDown() {
    }

    func testExample() {
    }

}

extension ListMediaPresenterTest {
    func testResumeAllOperationsLoadMedia() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)
        presenter.resumeAllOperationsLoadMedia()
        XCTAssertFalse(interactor.pendingOperations.downloadQueue.isSuspended)
        XCTAssertFalse(interactor.pendingOperations.filtrationQueue.isSuspended)
    }
    
    func testSuspendAllOperationsLoadMedia() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)
        presenter.suspendAllOperationsLoadMedia()
        XCTAssertTrue(interactor.pendingOperations.downloadQueue.isSuspended)
        XCTAssertTrue(interactor.pendingOperations.filtrationQueue.isSuspended)
    }
    
    func testChangeModeDisplay() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)
        let mode = ModeDisplay.Compact
        presenter.setModeDisplay(mode: mode)
        XCTAssertEqual(mode, interactor.getTypeDisplay())
    }
    
    func testRefreshData() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        presenter.refreshData {
            XCTAssertEqual([], presenter.getDataSource())
        }
    }
    func testValueIsFetchingWhenRequestFetchingData() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        presenter.requestFetchData { (indexPaths) in
            XCTAssertTrue(presenter.collectionViewIsFetchingData())
        }
    }

    func testCancelRequestWhenFetchingDataAgain() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        if IndexPath(item: 100, section: 0).item >= presenter.getDataSource().count - 1,
            !presenter.collectionViewIsFetchingData(),
            !presenter.stopRequestFetching {
            presenter.requestFetchData { (indexPaths) in
                
            }
        }
        if IndexPath(item: 100, section: 0).item >= presenter.getDataSource().count - 1,
            !presenter.collectionViewIsFetchingData(),
            !presenter.stopRequestFetching {
            presenter.requestFetchData { (indexPaths) in
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSuccesLoadMore() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        if IndexPath(item: 100, section: 0).item >= presenter.getDataSource().count - 1,
            !presenter.collectionViewIsFetchingData(),
            !presenter.stopRequestFetching {
            XCTAssertTrue(true)
        }
    }
    
    func testColumnInteritem() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        interactor.inject(modeDisplay: .Regular)
        presenter.inject(interactor: interactor, router: vc)

        let input = presenter.getColumnInteritem(model: NoteModel())
        let output = 0
        XCTAssertEqual(input, output)
    }
    
}
