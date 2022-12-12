//
//  ProductsViewControllerTests.swift
//  BeamDemoTests
//
//  Created by Macbook on 27/10/2021.
//

import XCTest
@testable import BeamDemo

final class ProductsViewControllerTests: XCTestCase {
    var sut: ProductsViewController!
    let localStorage: LocalStorageType = LocalStorage(storage: UserDefaults.init(suiteName: "LocalStorageTests")!)

    override func setUp() {
        super.setUp()
        let viewModel = ProductsViewModel(localStorage: localStorage)
        sut = ProductsViewController(viewModel: viewModel)
    }

    override func tearDown() {
        sut = nil
        localStorage.clearAllData()
        super.tearDown()
    }

    func test_emptyProducts_bottomTabBarViewIsHidden() {
        // when
        sut.viewWillAppear(false)
        // then
        XCTAssertTrue(sut.bottomTabBarView.isHidden)
    }

    func test_emptyProducts_onlyOneCellDisplays() {
        // when
        sut.viewWillAppear(false)
        let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        // then
        XCTAssertEqual(1, result)
    }

    func test_emptyProducts_emptyCellDisplays() {
        // when
        sut.viewWillAppear(false)
        let result = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // then
        XCTAssertTrue(result.isMember(of: EmptyProductsCell.self))
    }

    func test_oneProduct_bottomTabBarViewNotHidden() {
        // given
        localStorage.saveProduct(Product(id: 1, name: "test", description: "a"))
        // when
        sut.viewWillAppear(false)
        // then
        XCTAssertFalse(sut.bottomTabBarView.isHidden)
    }

    func test_oneProduct_oneCellIsDisplays() {
        // given
        localStorage.saveProduct(Product(id: 1, name: "test", description: "a"))
        // when
        sut.viewWillAppear(false)
        let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        // then
        XCTAssertEqual(1, result)
    }

    func test_oneProduct_productCellIsDisplays() {
        // given
        localStorage.saveProduct(Product(id: 1, name: "test", description: "a"))
        // when
        sut.viewWillAppear(false)
        let result = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // then
        XCTAssertTrue(result.isMember(of: ProductCell.self))
    }

    func test_threeProduct_threeCellIsDisplays() {
        // given
        localStorage.saveProduct(Product(id: 1, name: "test", description: "a"))
        localStorage.saveProduct(Product(id: 2, name: "test", description: "a"))
        localStorage.saveProduct(Product(id: 3, name: "test", description: "a"))
        // when
        sut.viewWillAppear(false)
        let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        // then
        XCTAssertEqual(3, result)
    }
}
