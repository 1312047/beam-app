//
//  BaseViewController.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    lazy var logoBarButtonItem: UIBarButtonItem = {
        let imageView = UIImageView(image: UIImage(named: "ic_logo"))
        imageView.widthAnchor.constraint(equalToConstant: 74.4).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        return UIBarButtonItem(customView: imageView)
    }()

    lazy var backBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()

    deinit {
        print("\(self.className) is deallocated")
    }
}
