//
//  ProductsViewModel.swift
//  BeamDemo
//
//  Created by Macbook on 26/10/2021.
//

import Foundation

protocol ProductsViewModelType: AnyObject {
    var isEmptyData: Bool { get }
    func numberOfItems() -> Int
    func getItem(at indexPath: IndexPath) -> Product?
    func refreshData()
}

final class ProductsViewModel: ProductsViewModelType {
    private var data: [Product]
    private var localStorage: LocalStorageType

    init(localStorage: LocalStorageType = LocalStorage.standard) {
        self.localStorage = localStorage
        data = localStorage.getAllProducts()
    }

    var isEmptyData: Bool {
        return data.isEmpty
    }

    func numberOfItems() -> Int {
        return data.count
    }

    func getItem(at indexPath: IndexPath) -> Product? {
        guard data.count > indexPath.row else { return nil }
        return data[indexPath.row]
    }

    func refreshData() {
        data = localStorage.getAllProducts()
    }
}
