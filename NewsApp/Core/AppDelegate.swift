//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 8/6/2564 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        
        return true
    }
    
    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let container = NewsListDependencyContainer()
        window?.rootViewController = UINavigationController(rootViewController: container.viewController)
        
        window?.makeKeyAndVisible()
    }
}

