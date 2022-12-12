//
//  SplashScreenViewController.swift
//  BeamDemo
//
//  Created by Hudson on 23/10/2021.
//

import UIKit

final class SplashScreenViewController: BaseViewController {
    // MARK: - Properties
    var heightGradientLine: CGFloat = 6
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_logo")
        return imageView
    }()
    
    private lazy var ghostBarButtonItem: UIBarButtonItem = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 74.4).isActive = true
        return UIBarButtonItem(customView: imageView)
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = AppString.welcomeTheFuture
        label.font = UIFont(bfont: .poppinsLight, size: 16)
        return label
    }()
    
    private lazy var gradientLineView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoImageViewConstraints: [NSLayoutConstraint]?
    private var gradientLineViews: [NSLayoutConstraint]?
    private var window: UIWindow? {
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            return sceneDelegate.window
        }
        return nil
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        resizeHeight()
        view.backgroundColor = .white
        customBackNavigationBarHomeView()
        window?.addSubview(logoImageView)
        window?.addSubview(gradientLineView)
        layoutConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        let image = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Actions
    private func customBackNavigationBarHomeView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func layoutConstraint() {
        guard let window = window, window.subviews.contains(logoImageView), window.subviews.contains(gradientLineView) else { return }
        logoImageViewConstraints = [
            logoImageView.centerYAnchor.constraint(equalTo: window.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        gradientLineViews = [
            gradientLineView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            gradientLineView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            gradientLineView.widthAnchor.constraint(equalTo: window.widthAnchor),
            gradientLineView.heightAnchor.constraint(equalToConstant: heightGradientLine)
        ]
        NSLayoutConstraint.activate(logoImageViewConstraints ?? [])
        NSLayoutConstraint.activate(gradientLineViews ?? [])
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -52)
        ])
    }
    
    private func setupController() {
        navigationItem.rightBarButtonItem = ghostBarButtonItem
    }
    
    private func logoAnimation() {
        UIView.animate(withDuration: 1, delay: 1,
                       animations: { [unowned self] in
                        guard let window = self.window,
                              let ghostView = ghostBarButtonItem.customView else { return }
                        NSLayoutConstraint.deactivate(self.logoImageViewConstraints ?? [])
                        NSLayoutConstraint.activate([
                            self.logoImageView.widthAnchor.constraint(equalTo: ghostView.widthAnchor),
                            self.logoImageView.heightAnchor.constraint(equalTo: ghostView.heightAnchor),
                            self.logoImageView.topAnchor.constraint(equalTo: ghostView.topAnchor),
                            self.logoImageView.leadingAnchor.constraint(equalTo: ghostView.leadingAnchor)
                        ])
                        window.layoutIfNeeded()
                       },
                       completion: { _ in
                        self.logoImageView.removeFromSuperview()
                        let vm = ProductsViewModel()
                        let vc = ProductsViewController(viewModel: vm)
                        let navigationController = BNavigationController(rootViewController: vc)
                        self.window?.rootViewController = navigationController
                        self.window?.addSubview(self.gradientLineView)
                        NSLayoutConstraint.activate(self.gradientLineViews ?? [])
                       })
    }
    
    private func resizeHeight() {
        switch UIDevice.current.getDeviceModel() {
        case .iPhone8PlusAndLower:
            heightGradientLine = 4
        case .iphoneXAndAbove:
            break
        case .ipad:
            break
        }
    }
}
