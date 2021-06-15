//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import UIKit

protocol NewsListRouting {
    func routeToDetail(article: Article)
}

final class NewsListRouter: NewsListRouting {
    private let container: NewsListDependencyContainer
    
    init(container: NewsListDependencyContainer) {
        self.container = container
    }
    
    func routeToDetail(article: Article) {
        let destinationContainer = ArticleDetailDependencyContainer(article: article)
        
        container.viewController.navigationController?.pushViewController(destinationContainer.viewController, animated: true)
    }
}
