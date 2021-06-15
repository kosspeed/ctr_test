//
//  ArticleDetailPresenter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import UIKit

protocol ArticleDetailPresentation {
    func initialize()
    func popBack()
}

protocol ArticleDetailPresenterOutput: class {
    func displayIntialize(articleViewModel: ArticleViewModel)
}

final class ArticleDetailPresenter {
    //MARK: Lifecycle
    private let interactor: ArticleDetailInteraction
    private let router: ArticleDetailRouting
    private weak var output: ArticleDetailPresenterOutput?
    
    init(interactor: ArticleDetailInteraction,
         router: ArticleDetailRouting,
         output: ArticleDetailPresenterOutput) {
        self.interactor = interactor
        self.router = router
        self.output = output
    }
}

//MARK: ArticleDetailPresentation
extension ArticleDetailPresenter: ArticleDetailPresentation {
    func initialize() {
        guard let article = interactor.article else { return }
        
        let formattedDate = article.publishedAt.dateStringToString(with: Date.kserviceDateFormat,
                                                              to: Date.mmmddCommaHHmmFormat)  ?? ""
        let updatedAt = "Updated: " + formattedDate
        
        let viewModel = ArticleViewModel(imageURL: URL(string: article.urlToImage),
                                         placeholderImage: UIImage(named: "ic_placeholder"),
                                         title: article.title,
                                         description: article.content,
                                         updatedAt: updatedAt)
        
        output?.displayIntialize(articleViewModel: viewModel)
    }
    
    func popBack() {
        router.popBack()
    }
}

//MARK: ArticleDetailInteractorOutput
extension ArticleDetailPresenter: ArticleDetailInteractorOutput {
    
}
