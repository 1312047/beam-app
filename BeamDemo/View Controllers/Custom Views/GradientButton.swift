//
//  GradientButton.swift
//  BeamDemo
//
//  Created by Hudson on 25/10/2021.
//

import UIKit

class GradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [#colorLiteral(red: 0.1764705882, green: 0.5294117647, blue: 0.9764705882, alpha: 1).cgColor, #colorLiteral(red: 0.2156862745, green: 0.7450980392, blue: 0.9176470588, alpha: 1).cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 8
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
