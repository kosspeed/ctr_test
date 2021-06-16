//
//  UIApplication+Extensions.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import UIKit

extension UIApplication {
    var topViewController: UIViewController? {
        let keyWindow = windows.first { $0.isKeyWindow }
        
        if keyWindow?.rootViewController == nil {
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }
}
