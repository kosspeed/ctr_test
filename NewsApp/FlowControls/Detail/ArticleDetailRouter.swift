//
//  ArticleDetailRouter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import Foundation

protocol ArticleDetailRouting {
    func popBack()
}

final class ArticleDetailRouter: ArticleDetailRouting {
    private let container: ArticleDetailDependencyContainer
    
    init(container: ArticleDetailDependencyContainer) {
        self.container = container
    }
    
    func popBack() {
        container.viewController.navigationController?.popViewController(animated: true)
    }
}
