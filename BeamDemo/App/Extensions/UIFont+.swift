//
//  UIFont+.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import UIKit

extension UIFont {
    enum BFont: String {
        case interRegular = "Inter-Regular"
        case interExtraLight = "Inter-ExtraLight"
        case interThin = "Inter-Thin"
        case interLight = "Inter-Light"
        case interMedium = "Inter-Medium"
        case interSemiBold = "Inter-SemiBold"
        case interBold = "Inter-Bold"
        case interExtraBold = "Inter-ExtraBold"
        case interBlack = "Inter-Black"
        case poppinsSemiBold = "Poppins-SemiBold"
        case poppinsRegular = "Poppins-Regular"
        case poppinsLight = "Poppins-Light"
        case poppinsMedium = "Poppins-Medium"
        case poppinsBold = "Poppins-Bold"
        case poppinsThin = "Poppins-Thin"
    }
    
    convenience init(bfont: BFont, size: CGFloat) {
        var size = size
        switch UIDevice.current.getDeviceModel() {
        case .iPhone8PlusAndLower:
            break
        case .iphoneXAndAbove:
            size += 2
        case .ipad:
            size += 4
        }
        self.init(name: bfont.rawValue, size: size)!
    }
}
