//
//  ProductViewControllerTests.swift
//  BeamDemoTests
//
//  Created by Macbook on 27/10/2021.
//

import XCTest
@testable import BeamDemo

final class ProductViewControllerTests: XCTestCase {
    var sut: ProductViewController!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_nameOfProduct_displayCorrect() {
        // given
        let product = Product(id: 1, name: "abc", description: "x")
        sut = ProductViewController(product: product)
        // when
        let result = sut.productNameLabel.text
        // then
        XCTAssertEqual(product.name, result)
    }
}
