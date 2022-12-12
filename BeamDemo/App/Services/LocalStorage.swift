//
//  LocalStorage.swift
//  BeamDemo
//
//  Created by Hudson on 25/10/2021.
//

import Foundation

protocol LocalStorageType: AnyObject {
    func saveProduct(_ product: Product)
    func getAllProducts() -> [Product]
    func clearAllData()
}

final class LocalStorage: LocalStorageType {
    typealias RawValue = String
    
    struct Keys: RawRepresentable {
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        static let products = Keys(rawValue: "products")
    }
    
    private let storage: UserDefaults
    private let queueLabel = "LocalStorage"
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    static var standard: LocalStorage {
        return LocalStorage(storage: UserDefaults.standard)
    }
    
    init(storage: UserDefaults) {
        self.storage = storage
    }

    private func get<T>(key: Keys) -> T? {
        return storage.object(forKey: key.rawValue) as? T
    }

    private func save<T>(value: T?, key: Keys,
                         async: Bool = false) {
        if async {
            let queue = DispatchQueue(label: queueLabel)
            queue.async { [weak self] in
                self?.storage.set(value, forKey: key.rawValue)
            }
        } else {
            storage.set(value, forKey: key.rawValue)
        }
    }

    private func saveCodableArray<T: Codable>(_ array: [T], key: Keys, async: Bool = false) {
        if let jsonData = try? jsonEncoder.encode(array) {
            save(value: jsonData, key: key, async: async)
        } else {
            print("Cannot save UserProfile to UserDefault")
        }
    }

    private func getCodableArray<T: Codable>(key: Keys) -> [T]? {
        if let jsonData: Data = get(key: key) {
            return try? jsonDecoder.decode([T].self, from: jsonData)
        }
        return nil
    }

    /// Save product to local storage
    ///
    /// - Parameters:
    ///   - key: Unique key for each value.
    func saveProduct(_ product: Product) {
        var data: [Product] = getCodableArray(key: .products) ?? []
        data.append(product)
        saveCodableArray(data, key: .products)
    }

    /// Get all products from local storage
    func getAllProducts() -> [Product] {
        return getCodableArray(key: .products) ?? []
    }

    /// Get all data
    func clearAllData() {
        let dictionary = storage.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            storage.removeObject(forKey: key)
        }
    }
}
