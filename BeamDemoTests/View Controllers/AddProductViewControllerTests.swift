//
//  AddProductViewControllerTests.swift
//  BeamDemoTests
//
//  Created by Macbook on 27/10/2021.
//

import XCTest
@testable import BeamDemo

final class AddProductViewControllerTests: XCTestCase {
    var sut: AddProductViewController!
    let localStorage: LocalStorageType = LocalStorage(storage: UserDefaults.init(suiteName: "LocalStorageTests")!)

    override func tearDown() {
        sut = nil
        localStorage.clearAllData()
        super.tearDown()
    }

    func test_nameOfProduct_displayCorrect() {
        // given
        let product = Product(id: 1, name: "abc", description: "x")
        sut = AddProductViewController(product: product, localStorage: localStorage)
        // when
        let result = sut.productNameLabel.text
        // then
        XCTAssertEqual(product.name, result)
    }

    func test_addProduct_success() {
        // given
        let product = Product(id: 1, name: "abc", description: "x")
        sut = AddProductViewController(product: product, localStorage: localStorage)
        // when
        sut.confirmButtonTapped()
        let result = localStorage.getAllProducts()
        // then
        XCTAssertEqual([product], result)
    }
}
