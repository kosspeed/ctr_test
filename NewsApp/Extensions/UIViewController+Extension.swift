//
//  UIViewController+Extension.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

import UIKit

extension UIViewController {
    func alert(with title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertInputDialog(title: String? = nil,
                          message: String? = nil,
                          actionHandler: ((_ text: String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = nil
            textField.keyboardType = .default
        }
        
        let textFieldAction = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let textField = alert.textFields?.first, let text = textField.text else {
                return
            }
            
            
            if !text.isEmpty {
                actionHandler?(text)
            }
        }
        
        alert.addAction(textFieldAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var topViewController: UIViewController? {
        return UIApplication.shared.topViewController
    }
    
    var topNavController: UINavigationController? {
        return UIApplication.shared.topViewController as? UINavigationController
    }
    
    var topTabController: UITabBarController? {
        return UIApplication.shared.topViewController as? UITabBarController
    }
}
