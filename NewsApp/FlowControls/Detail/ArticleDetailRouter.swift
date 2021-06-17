//
//  ArticleDetailRouter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import Foundation

protocol ArticleDetailRouting {
    var container: ArticleDetailDependencyContainer { get set }
    
    func popBack()
}

final class ArticleDetailRouter: ArticleDetailRouting {
    var container: ArticleDetailDependencyContainer
    
    init(container: ArticleDetailDependencyContainer) {
        self.container = container
    }
    
    func popBack() {
        container.viewController.topNavController?.popViewController(animated: true)
    }
}
