//
//  ArticleDetailDependencyContainer.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import UIKit

final class ArticleDetailDependencyContainer {
    let viewController: ArticleDetailViewController
    let interactor: ArticleDetailInteractor
    
    init(article: Article) {
        viewController = ArticleDetailViewController()
        interactor = ArticleDetailInteractor()
        
        let router = ArticleDetailRouter(container: self)
        let presenter = ArticleDetailPresenter(interactor: interactor,
                                               router: router,
                                               output: viewController)
        interactor.article = article
        interactor.output = presenter
        viewController.presenter = presenter
    }
    
    deinit {
        print("ArticleDetailDependencyContainer deinit")
    }
}
