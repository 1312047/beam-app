//
//  HomeWithProductTableViewCell.swift
//  BeamDemo
//
//  Created by Macbook on 26/10/2021.
//

import UIKit

final class ProductCell: UITableViewCell {
    private lazy var cameraImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_lens")
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont(bfont: .interRegular, size: 16)
        return label
    }()
    
    private lazy var canonImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "icon_canon")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cameraImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(canonImageView)
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.layer.shadowColor = #colorLiteral(red: 0.05098039216, green: 0.2431372549, blue: 0.431372549, alpha: 0.12)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 5
        contentView.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            cameraImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cameraImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cameraImageView.widthAnchor.constraint(equalToConstant: 24),
            cameraImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cameraImageView.trailingAnchor, constant: 10),
            canonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            canonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18)
        ])
        let constraint = cameraImageView.heightAnchor.constraint(equalToConstant: 50)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 5, right: 20))
    }
}
