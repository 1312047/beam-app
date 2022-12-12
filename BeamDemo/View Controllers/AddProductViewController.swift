//
//  AddProductViewController.swift
//  BeamDemo
//
//  Created by Hudson on 24/10/2021.
//

import UIKit
// swiftlint:disable type_body_length
final class AddProductViewController: BaseViewController {
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets.zero
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var canonImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "icon_canon")
        return image
    }()
    
    private lazy var cameraImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_camera")
        return image
    }()
    
    private lazy var documentsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_documents")
        return image
    }()
    
    private lazy var contactsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_contacts")
        return image
    }()
    
    private lazy var linksImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_links")
        return image
    }()
    
    private lazy var imeiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.imei
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 18)
        return label
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = product.name
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = product.description
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(bfont: .interLight, size: 14)
        return label
    }()
    
    private lazy var resoucesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.resouces
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(bfont: .interMedium, size: 14)
        return label
    }()
    
    private lazy var documentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.documents
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 12)
        return label
    }()
    
    private lazy var contactsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.contacts
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 12)
        return label
    }()
    
    private lazy var linksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.links
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 12)
        return label
    }()
    
    private lazy var documentsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 2
        stack.addArrangedSubview(documentsImageView)
        stack.addArrangedSubview(documentsLabel)
        return stack
    }()
    
    private lazy var contactsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 2
        stack.addArrangedSubview(contactsImageView)
        stack.addArrangedSubview(contactsLabel)
        return stack
    }()
    
    private lazy var linksStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 2
        stack.addArrangedSubview(linksImageView)
        stack.addArrangedSubview(linksLabel)
        return stack
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.addArrangedSubview(documentsStackView)
        stack.addArrangedSubview(contactsStackView)
        stack.addArrangedSubview(linksStackView)
        return stack
    }()
    
    private lazy var reScanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.setTitle(AppString.Product.reScan, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(bfont: .interSemiBold, size: 14)
        button.addTarget(self, action: #selector(reScanButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(AppString.Product.confirm, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 42).isActive = true
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 18
        stack.addArrangedSubview(reScanButton)
        stack.addArrangedSubview(confirmButton)
        return stack
    }()

    private let product: Product
    private let localStorage: LocalStorageType

    init(product: Product, localStorage: LocalStorageType = LocalStorage.standard) {
        self.localStorage = localStorage
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.setHidesBackButton(false, animated: true)
    }

    // MARK: - Methods
    private func setupView() {
        navigationItem.rightBarButtonItem = logoBarButtonItem
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(canonImageView)
        containerView.addSubview(imeiLabel)
        containerView.addSubview(cameraImageView)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(resoucesLabel)
        containerView.addSubview(totalStackView)
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            canonImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 7),
            canonImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 52),
            canonImageView.widthAnchor.constraint(equalToConstant: 80),
            canonImageView.heightAnchor.constraint(equalToConstant: 50),
            imeiLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 20),
            imeiLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -52),
            cameraImageView.topAnchor.constraint(equalTo: canonImageView.bottomAnchor, constant: 10),
            cameraImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            productNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            productNameLabel.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor, constant: 24),
            descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            resoucesLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            resoucesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            totalStackView.topAnchor.constraint(equalTo: resoucesLabel.bottomAnchor, constant: 10),
            totalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
            totalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            totalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }

    // MARK: - Actions
    @objc private func reScanButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func confirmButtonTapped() {
        localStorage.saveProduct(product)
        guard let productsViewController = navigationController?.viewControllers.first else { return }
        navigationController?.viewControllers = [productsViewController, self]
        navigationController?.popViewController(animated: true)
    }
}
