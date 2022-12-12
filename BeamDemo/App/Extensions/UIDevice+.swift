//
//  UIDevice+.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import UIKit

enum BUIDeviceModel {
    case iPhone8PlusAndLower
    case iphoneXAndAbove
    case ipad
}

extension UIDevice {
    func getDeviceModel() -> BUIDeviceModel {
        if  UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136, 1334, 1920, 2208:
                return .iPhone8PlusAndLower
            case 2436, 2688, 1792:
                return .iphoneXAndAbove
            default:
                return .iphoneXAndAbove
            }
        }
        return .ipad
    }
}
