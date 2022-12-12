//
//  String+.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
