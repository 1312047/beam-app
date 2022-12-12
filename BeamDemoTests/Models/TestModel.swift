//
//  TestModel.swift
//  BeamDemoTests
//
//  Created by Hudson on 25/10/2021.
//

import Foundation

struct TestModel: Codable, Equatable {
    let id: Int
    var name: String
    let age: Int
    let isVietnamese: Bool

    init(id: Int, name: String, age: Int, isVietnamese: Bool) {
        self.id = id
        self.name = name
        self.age = age
        self.isVietnamese = isVietnamese
    }
}
