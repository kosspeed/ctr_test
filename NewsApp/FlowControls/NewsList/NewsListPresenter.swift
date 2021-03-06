//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import UIKit

protocol NewsListPresentation {
    var sections: Int { get }
    var numberOfRows: Int { get }
    var hasNext: Bool { get }
    var isLoading: Bool { get }
    var isEmpty: Bool { get }
    var isFiltering: Bool { get }
    
    func article(at index: Int) -> Article?
    func articleViewModel(at index: Int) -> ArticleViewModel?
    func fetchNewsList(nextPage: Bool)
    func filterArticles(by text: String)
    func resetFilterState()
    func select(article: Article)
}

protocol NewsListPresenterOutput: class {
    func displayNewsList()
    func displayError(message: String)
}

final class NewsListPresenter {
    //MARK: Lifecycle
    private let interactor: NewsListInteraction
    private let router: NewsListRouting
    private weak var output: NewsListPresenterOutput?
    
    //MARK: Properties
    var newsList: NewsList?
    var filteredNewsList: NewsList?
    
    private var articleViewModels: [ArticleViewModel]?
    private var filteredArticleViewModels: [ArticleViewModel]?
    private var defaultDate: Date
    private var loading: Bool
    private var filtering: Bool
    
    private lazy var placeholderImage: UIImage = {
        return UIImage(named: "ic_placeholder") ?? UIImage()
    }()
    
    init(interactor: NewsListInteraction,
         router: NewsListRouting,
         output: NewsListPresenterOutput? = nil) {
        self.interactor = interactor
        self.router = router
        self.output = output
        
        defaultDate = Date()
        loading = false
        filtering = false
    }
    
    //MARK: Presentation
    var sections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return filtering ?
            filteredNewsList?.articles?.count ?? 0 :
            newsList?.articles?.count ?? 0
    }
    
    var hasNext: Bool {
        return filtering ? false : newsList?.hasNext ?? false
    }
    
    var isLoading: Bool {
        return loading
    }
    
    var isFiltering: Bool {
        return filtering
    }
    
    var isEmpty: Bool {
        return filtering ?
            filteredNewsList?.articles?.isEmpty ?? true :
            newsList?.articles?.isEmpty ?? true
    }
    
    func article(at index: Int) -> Article? {
        return filtering ? filteredNewsList?.articles?[index] : newsList?.articles?[index]
    }
    
    func articleViewModel(at index: Int) -> ArticleViewModel? {
        return filtering ? filteredArticleViewModels?[index] : articleViewModels?[index]
    }
}

//MARK: NewsListPresentation
extension NewsListPresenter: NewsListPresentation {
    func fetchNewsList(nextPage: Bool) {
        if nextPage {
            newsList?.nextPage()
        }
        
        let size: Int = newsList?.size ?? 10
        let page: Int = newsList?.page ?? 1
        
        interactor.fetchNewsList(from: defaultDate,
                                 to: defaultDate,
                                 size: size,
                                 page: page)
        
        loading = true
    }
    
    func filterArticles(by text: String) {
        if !text.isEmpty {
            filtering = true
            
            interactor.filterArticles(with: text)
        } else {
            filtering = false
            
            output?.displayNewsList()
        }
    }
    
    func resetFilterState() {
        filtering = false
        
        output?.displayNewsList()
    }
    
    func select(article: Article) {
        router.routeToDetail(article: article)
    }
}

//MARK: NewsListInteractorOutput
extension NewsListPresenter: NewsListInteractorOutput {
    func didFetchNewsListSuccess(newsList: NewsList) {
        self.newsList = newsList
        
        articleViewModels = buildArticleViewModels(articles: self.newsList?.articles ?? [])
        
        output?.displayNewsList()
        
        loading = false
    }
    
    func didFetchNewsListError(error: Error) {
        output?.displayError(message: error.localizedDescription)
    }
    
    func didFilter(newsList: NewsList) {
        filteredNewsList = newsList
        
        filteredArticleViewModels = buildArticleViewModels(articles: newsList.articles ?? [])
        
        output?.displayNewsList()
    }
    
    private func buildArticleViewModels(articles: [Article]) -> [ArticleViewModel] {
        return articles.map {
            let formattedDate = $0.publishedAt.dateStringToString(with: Date.kserviceDateFormat,
                                                                  to: Date.mmmddCommaHHmmFormat)  ?? ""
            let updatedAt = "Updated: " + formattedDate
            
            return ArticleViewModel(imageURL: URL(string: $0.urlToImage),
                                    placeholderImage: placeholderImage,
                                    title: $0.title,
                                    description: $0.description,
                                    updatedAt: updatedAt)
        }
    }
}
