//
//  ListMediaViewControllerTests.swift
//  AssessmentRound1TechBaseUITests
//
//  Created by Azibai on 01/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import XCTest
@testable import AssessmentRound1TechBase

class ListMediaViewControllerTests: XCTestCase {
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
// MARK: - Tests when load view
extension ListMediaViewControllerTests {
    func testCollectionViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(vc?.getCollectionView())
    }
    
    func testSegmentViewNotNilAfterViewDidload() {
        XCTAssertNotNil(vc?.getSegmentView())
    }
    
    func testBottomLoadingViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(vc?.getBottomLoadingView())
    }
    
    func testLoadViewSetCollectionViewDelegate() {
        XCTAssertTrue(vc?.getCollectionView()?.delegate is ListMediaCollectionViewDelegate)
    }
    
    func testLoadViewSetCollectionViewDataSource() {
        XCTAssertTrue(vc?.getCollectionView()?.dataSource is ListMediaCollectionViewDataSource)
    }
    
    func testSegmentViewSetInputDelegate() {
        XCTAssertTrue(vc?.getSegmentView()?.delegate is ListMediaViewController)
    }
    
    func testCollectionViewSetUIRefreshControl() {
        let refresh = vc?.getCollectionView()?.refreshControl
        XCTAssertNotNil(refresh)
    }

    func testLoadViewSetEdgeInsetsForCollectionView() {
        let expectedInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        XCTAssertEqual(vc?.getCollectionView()?.contentInset, expectedInsets)
    }

  
    func testShowLoadingWhenFetchingData() {
        
    }
    
    func testSegmentChangeValueToReloadUI() {
        
    }
}

//MARK: - Tests ListMediaCollectionViewDataSource
extension ListMediaViewControllerTests {
    
    func testCellForRow_WhenIndexPathOutOfRange_NotCrash() {
        guard let collectionView = vc?.getCollectionView() else { return }
        let cell = collectionView.cellForItem(at: IndexPath(item: 100, section: 100))
        XCTAssertNil(cell)
    }
    
    func testDataSourceAtIndexPathOutOfRangeReturnNil() {
        guard
            let delegate = vc,
            let collectionView = vc?.getCollectionView(),
            let dataSource = collectionView.dataSource as? ListMediaCollectionViewDataSource else { return }
        XCTAssertNil(dataSource.presenter?.cellForItemAt(indexPath: IndexPath(item: 10000, section: 0), delegate: delegate)
)
    }
}

// MARK: - Tests UICollectionViewDelegateFlowLayout
extension ListMediaViewControllerTests {
    func testMinimumLineSpacing() {
        guard
            let collectionView = vc?.getCollectionView(),
            let collectionViewLayout = collectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout else { return }
        
        XCTAssertEqual(collectionViewLayout.minimumLineSpacing, 10)
    }

    func testMinimumInteritemSpacing() {
        guard
            let collectionView = vc?.getCollectionView(),
            let collectionViewLayout = collectionView.collectionViewLayout as? LeftAlignedCollectionViewFlowLayout else { return }
        
        XCTAssertEqual(collectionViewLayout.minimumInteritemSpacing, 10)
    }

    func testCollectionViewIsLayoutAlignedLeft() {
        XCTAssertTrue(vc?.getCollectionView()?.collectionViewLayout is LeftAlignedCollectionViewFlowLayout)
    }
    
    func testSizeForItemWhenIndexOutOfRangeReturnZero() {
        guard let cls = vc?.getCollectionView(),
            let delegateCls = cls.delegate as? ListMediaCollectionViewDelegate else { return }
        let size = delegateCls.collectionView(cls, layout: cls.collectionViewLayout, sizeForItemAt: IndexPath(item: 1000, section: 1000))
        XCTAssertEqual(size, .zero)
    }
    
}

//MARK: -Test Handle
extension ListMediaViewControllerTests {
    func testClearCacheSizeWhenChangeMode() {
        let presenter = ListMediaPresenterImp()
        let interactor = ListMediaInteractorImp()
        presenter.inject(interactor: interactor, router: vc)
        vc?.inject(presenter: presenter)
        presenter.requestFetchData { _ in
            DispatchQueue.main.async {
                self.vc?.segmentViewchangeMode(at: .compact)
                let dataModel = presenter.getDataSource()[safe: 0]
                XCTAssertEqual(dataModel?.finalHeight, -1)
                XCTAssertEqual(dataModel?.finalWidth, -1)
            }
        }
    }
}
