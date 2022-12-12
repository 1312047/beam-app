//
//  UITableView+.swift
//  BeamDemo
//
//  Created by Macbook on 26/10/2021.
//

import UIKit

extension UITableView {
    
    func registerWithClassName(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func registerClassWithClassName(cellType: UITableViewCell.Type) {
        let className = cellType.className
        register(cellType, forCellReuseIdentifier: className)
    }
    
    func registerWithClassName(reusableViewType: UITableViewHeaderFooterView.Type,
                               bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerClassWithClassName(reusableViewType: UITableViewHeaderFooterView.Type) {
        let className = reusableViewType.className
        register(reusableViewType, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueReusableCellWithClassName<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
        // swiftlint:enable force_cast
    }
    
    func dequeueReusableViewWithClassName<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
        // swiftlint:enable force_cast
    }
    
    func hasRowAt(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
}
