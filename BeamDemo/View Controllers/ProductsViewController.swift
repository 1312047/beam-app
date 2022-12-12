//
//  HomeWithProductViewController.swift
//  BeamDemo
//
//  Created by Hudson on 25/10/2021.
//

import UIKit

final class ProductsViewController: BaseViewController, UITableViewDelegate,
                                    UITableViewDataSource, EmptyProductsCellDelegate {
    // MARK: - Properties
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.contentMode = .center
        image.tintColor = UIColor(.themeAccent)
        image.image = UIImage(named: "ic_products")
        return image
    }()
    
    private lazy var scanImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.tintColor = #colorLiteral(red: 0.3960784314, green: 0.537254902, blue: 0.7411764706, alpha: 1)
        image.contentMode = .center
        image.image = UIImage(named: "ic_scan")
        return image
    }()

    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(.themeBlack)
        label.text = AppString.Product.products
        label.numberOfLines = 0
        label.font = UIFont(bfont: .poppinsMedium, size: 24)
        return label
    }()
    
    private lazy var linksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(.themeBlack)
        label.text = AppString.Product.links
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 12)
        return label
    }()
    
    private lazy var productTabBarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(.themeAccent)
        label.text = AppString.Product.products
        label.numberOfLines = 1
        label.font = UIFont(bfont: .poppinsMedium, size: 12)
        return label
    }()
    
    private lazy var scanTabBarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(.themeAccent)
        label.text = AppString.Product.scan
        label.tintColor = #colorLiteral(red: 0.3960784314, green: 0.537254902, blue: 0.7411764706, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 12)
        return label
    }()
    
    lazy var bottomTabBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var productStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.addArrangedSubview(productImageView)
        stack.addArrangedSubview(productTabBarLabel)
        return stack
    }()
    
    private lazy var scanStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(scanStackTapped))
        stack.addGestureRecognizer(gesture)
        stack.distribution = .fill
        stack.axis = .vertical
        stack.addArrangedSubview(scanImageView)
        stack.addArrangedSubview(scanTabBarLabel)
        return stack
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.registerClassWithClassName(cellType: ProductCell.self)
        tableView.registerClassWithClassName(cellType: EmptyProductsCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        return tableView
    }()

    private let viewModel: ProductsViewModelType

    init(viewModel: ProductsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        customBackNavigationBarHomeView()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
        tableView.reloadData()
        navigationItem.setHidesBackButton(true, animated: false)
        bottomTabBarView.isHidden = viewModel.isEmptyData
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let yourBackImage = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
    // MARK: - Scan tapped
    @objc private func scanStackTapped() {
        let vc = ScannerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
extension ProductsViewController {
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(productLabel)
        view.addSubview(tableView)
        view.addSubview(bottomTabBarView)
        bottomTabBarView.addSubview(productStackView)
        bottomTabBarView.addSubview(scanStackView)
        NSLayoutConstraint.activate([
            productLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            productLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            bottomTabBarView.heightAnchor.constraint(equalToConstant: 50),
            bottomTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            bottomTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productStackView.topAnchor.constraint(equalTo: bottomTabBarView.topAnchor),
            productStackView.bottomAnchor.constraint(equalTo: bottomTabBarView.bottomAnchor),
            productStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            productStackView.widthAnchor.constraint(equalToConstant: 65),
            scanStackView.topAnchor.constraint(equalTo: bottomTabBarView.topAnchor, constant: 2),
            scanStackView.bottomAnchor.constraint(equalTo: bottomTabBarView.bottomAnchor),
            scanStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            scanStackView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func customBackNavigationBarHomeView() {
        navigationItem.rightBarButtonItem = logoBarButtonItem
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    // MARK: - Table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isEmptyData {
            return 1
        }
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isEmptyData {
            let cell = tableView.dequeueReusableCellWithClassName(with: EmptyProductsCell.self, for: indexPath)
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCellWithClassName(with: ProductCell.self, for: indexPath)
        let item = viewModel.getItem(at: indexPath)
        cell.nameLabel.text = item?.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.isEmptyData == false,
              let product = viewModel.getItem(at: indexPath) else { return }
        let vc = ProductViewController(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - EmptyProductsCellDelegate
    func emptyProductsCell(cell: EmptyProductsCell, scanButtonDidTap button: UIButton) {
        let vc = ScannerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
