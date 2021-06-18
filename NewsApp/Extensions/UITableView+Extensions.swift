//
//  UITableView+Extensions.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 13/6/2564 BE.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String = T.stringClass) {
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.stringClass, for: indexPath) as! T
    }
}
