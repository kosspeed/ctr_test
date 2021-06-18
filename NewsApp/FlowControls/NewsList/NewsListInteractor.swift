//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import Foundation
import RxSwift

protocol NewsListInteraction {
    var newsList: NewsList? { get set }
    var filteredNewsList: NewsList? { get set }
    
    func fetchNewsList(from startDate: Date, to endDate: Date, size: Int, page: Int)
    func filterArticles(with text: String)
}

protocol NewsListInteractorOutput: class {
    func didFetchNewsListSuccess(newsList: NewsList)
    func didFetchNewsListError(error: Error)
    func didFilter(newsList: NewsList)
}

class NewsListInteractor {
    //MARK: Lifecycle
    weak var output: NewsListInteractorOutput?
    
    //MARK: Output
    var newsList: NewsList?
    var filteredNewsList: NewsList?
    
    //MARK: Internal
    private let fetchNewsListUseCase: FetchNewsListUseCase
    private let disposeBag: DisposeBag
    
    init(fetchNewsListUseCase: FetchNewsListUseCase = FetchNewsListUseCaseImpl()) {
        self.fetchNewsListUseCase = fetchNewsListUseCase
        disposeBag = DisposeBag()
    }
}

//MARK: NewsListInteraction
extension NewsListInteractor: NewsListInteraction {
    func fetchNewsList(from startDate: Date, to endDate: Date, size: Int, page: Int) {
        let formattedStartDate = startDate.toString(by: Date.YYYYDashMMDashddFormat)
        let formattedEndDate = endDate.toString(by: Date.YYYYDashMMDashddFormat)
        
        fetchNewsListUseCase
            .execute(from: formattedStartDate, to: formattedEndDate, size: size, page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (newsList) in
                if self?.newsList == nil {
                    self?.newsList = newsList
                } else {
                    if let articles = newsList.articles {
                        self?.newsList?.articles?.append(contentsOf: articles)
                    }
                }
                
                if let wrappedNewsList = self?.newsList {
                    self?.output?.didFetchNewsListSuccess(newsList: wrappedNewsList)
                }
            }, onError: { [weak self] (error) in
                self?.output?.didFetchNewsListError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    func filterArticles(with text: String) {
        filteredNewsList = newsList
        filteredNewsList?.articles = newsList?.articles?.filter {
            let formattedText = text.lowercased()
            
            return $0.title.lowercased().contains(formattedText) || $0.description.lowercased().contains(formattedText)
        }
        
        if let wrappedFilteredNewsList = filteredNewsList {
            output?.didFilter(newsList: wrappedFilteredNewsList)
        }
    }
}
