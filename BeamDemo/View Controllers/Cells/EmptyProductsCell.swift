//
//  EmptyProductsCell.swift
//  BeamDemo
//
//  Created by Macbook on 26/10/2021.
//

import UIKit

protocol EmptyProductsCellDelegate: AnyObject {
    func emptyProductsCell(cell: EmptyProductsCell, scanButtonDidTap button: UIButton)
}

final class EmptyProductsCell: UITableViewCell {
    private lazy var zeroProductsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppString.Product.zeroProducts
        label.font = UIFont(bfont: .poppinsRegular, size: 16)
        label.textColor = UIColor(.themeBlack)
        return label
    }()

    private lazy var addYourFirstProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(.themeBlack)
        label.text = AppString.Product.addFirstProduct
        label.font = UIFont(bfont: .poppinsRegular, size: 14)
        return label
    }()

    private lazy var scanImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_scan")
        return image
    }()

    private lazy var scanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(.themeAccent)
        label.text = AppString.Product.scan
        label.font = UIFont(bfont: .poppinsMedium, size: 22)
        return label
    }()

    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: EmptyProductsCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(zeroProductsLabel)
        contentView.addSubview(addYourFirstProductLabel)
        contentView.addSubview(scanButton)
        scanButton.addSubview(scanImageView)
        scanButton.addSubview(scanLabel)
        NSLayoutConstraint.activate([
            zeroProductsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            zeroProductsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scanImageView.centerXAnchor.constraint(equalTo: scanButton.centerXAnchor),
            scanImageView.topAnchor.constraint(equalTo: scanButton.topAnchor, constant: 10),
            scanImageView.widthAnchor.constraint(equalToConstant: 28),
            scanImageView.heightAnchor.constraint(equalToConstant: 28),
            scanLabel.topAnchor.constraint(equalTo: scanImageView.bottomAnchor, constant: 10),
            scanLabel.centerXAnchor.constraint(equalTo: scanButton.centerXAnchor),
            scanButton.topAnchor.constraint(equalTo: zeroProductsLabel.bottomAnchor, constant: 150),
            scanButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: 100),
            scanButton.heightAnchor.constraint(equalToConstant: 100),
            scanButton.bottomAnchor.constraint(equalTo: addYourFirstProductLabel.topAnchor),
            addYourFirstProductLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addYourFirstProductLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func scanButtonTapped() {
        delegate?.emptyProductsCell(cell: self, scanButtonDidTap: scanButton)
    }
}
