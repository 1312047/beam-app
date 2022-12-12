//
//  BeamDemoTests.swift
//  BeamDemoTests
//
//  Created by Hudson on 25/10/2021.
//

import XCTest
@testable import BeamDemo

extension LocalStorage.Keys {
    static let unitTest = LocalStorage.Keys(rawValue: "unitTest")
}

final class LocalStorageTests: XCTestCase {
    var sut: LocalStorageType = LocalStorage(storage: UserDefaults.init(suiteName: "LocalStorageTests")!)

    override func tearDown() {
        sut.clearAllData()
        super.tearDown()
    }

    func test_emptyProducts_atTheBeginning() {
        // when
        let result: [Product] = sut.getAllProducts()
        // then
        XCTAssertEqual(result, [])
    }

    func test_saveProduct() {
        // given
        let product = Product(id: 1, name: "test", description: "a")
        // when
        sut.saveProduct(product)
        let result: [Product] = sut.getAllProducts()
        // then
        XCTAssertEqual(result, [product])
    }

    func test_saveTwoProducts() {
        // given
        let product1 = Product(id: 1, name: "test 1", description: "a")
        let product2 = Product(id: 2, name: "test 2", description: "a")
        // when
        sut.saveProduct(product1)
        sut.saveProduct(product2)
        let result: [Product] = sut.getAllProducts()
        // then
        XCTAssertEqual(result, [product1, product2])
    }
}
