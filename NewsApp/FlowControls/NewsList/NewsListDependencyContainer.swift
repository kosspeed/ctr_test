//
//  NewsListDependencyContainer.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import Foundation

final class NewsListDependencyContainer {
    let viewController: NewsListViewController
    
    init() {
        viewController = NewsListViewController()
        let interactor = NewsListInteractor()
        let router = NewsListRouter(container: self)
        let presenter = NewsListPresenter(interactor: interactor,
                                          router: router,
                                          output: viewController)
        interactor.output = presenter
        viewController.presenter = presenter
    }
}
