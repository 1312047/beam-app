//
//  BNavigationController.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import UIKit

final class BNavigationController: UINavigationController {
    // MARK: - Methods
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.backItem?.title = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.backItem?.title = ""
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.setBackgroundImage(UIImage(), for: .compact)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.backItem?.title = ""
        navigationBar.barTintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.backItem?.title = ""
    }
}
