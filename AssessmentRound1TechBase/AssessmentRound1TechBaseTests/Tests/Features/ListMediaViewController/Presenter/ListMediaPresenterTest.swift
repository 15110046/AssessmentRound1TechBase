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
        vc = ListMediaViewController.create() as? ListMediaViewController
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
        let mode = ModeDisplay.compact
        presenter.setModeDisplay(mode: .compact, delegate: vc!, indexPathsVisible: [])
        XCTAssertEqual(mode, interactor.getTypeDisplay())
    }
    
    func testRefreshData() {
        guard let delegate = vc else { return }
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)
        presenter.refreshData(delegate: delegate)
        XCTAssertEqual([], presenter.getDataSource())
    }
    
    func testValueIsFetchingWhenRequestFetchingData() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        presenter.requestFetchData { (indexPaths) in
            DispatchQueue.main.async {
                XCTAssertTrue(presenter.collectionViewIsFetchingData())
            }
        }
    }

    func testCancelRequestWhenFetchingDataAgain() {
        guard let delegate = vc else { return }
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)

        presenter.collectionViewWillDisplay(forItemAt: IndexPath(item: presenter.getDataSource().count - 1, section: 0), delegate: delegate)
        
        presenter.requestFetchData { _ in
            DispatchQueue.main.async {
                XCTAssertTrue(false)
            }
        }
    }
    
}
