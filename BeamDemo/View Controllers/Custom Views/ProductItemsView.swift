//
//  ProductItems.swift
//  BeamDemo
//
//  Created by Thomas on 25/10/2021.
//

import UIKit

class ProductItemsView: UIView {
    
    private lazy var cameraImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ic_lens")
        return image
    }()
    
    private lazy var ef50mmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = AppString.Product.ef50mm
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    private func initSubviews() {
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.cornerRadius = 8
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        layoutConstraint()
    }
    
    private func layoutConstraint() {
        addSubview(cameraImageView)
        addSubview(ef50mmLabel)
        addSubview(canonImageView)
        NSLayoutConstraint.activate([
            cameraImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cameraImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            ef50mmLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ef50mmLabel.leadingAnchor.constraint(equalTo: cameraImageView.trailingAnchor, constant: 10),
            
            canonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            canonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
}
