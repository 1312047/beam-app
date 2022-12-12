//
//  SceneDelegate.swift
//  BeamDemo
//
//  Created by Hudson on 22/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private lazy var rootViewController: UIViewController = {
        let splashViewController = SplashScreenViewController()
        let navigationController = UINavigationController(rootViewController: splashViewController)
        return navigationController
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = self.window
    }
}
