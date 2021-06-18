//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import UIKit

protocol NewsListRouting {
    var container: NewsListDependencyContainer { get set }
    
    func routeToDetail(article: Article)
}

final class NewsListRouter: NewsListRouting {
    var container: NewsListDependencyContainer
    
    init(container: NewsListDependencyContainer) {
        self.container = container
    }
    
    func routeToDetail(article: Article) {
        let destinationContainer = ArticleDetailDependencyContainer(article: article)
        
        container.viewController.topNavController?.pushViewController(destinationContainer.viewController, animated: true)
    }
}
