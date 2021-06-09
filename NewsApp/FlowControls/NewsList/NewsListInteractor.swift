//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import Foundation
import RxSwift

protocol NewsListInteraction {
    func fetchNewsList(from startDate: Date, to endDate: Date, size: Int, page: Int)
    func filterArticles(with newsList: NewsList, text: String)
}

protocol NewsListInteractorOutput: class {
    func didFetchNewsListSuccess(newsList: NewsList)
    func didFetchNewsListError(error: Error)
    
    func didFilter(newsList: NewsList)
}

final class NewsListInteractor {
    //MARK: Lifecycle
    weak var output: NewsListInteractorOutput?
    
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
            .fetchNews(from: formattedStartDate, to: formattedEndDate, size: size, page: page)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (newsList) in
                self?.output?.didFetchNewsListSuccess(newsList: newsList)
            }, onError: { [weak self] (error) in
                self?.output?.didFetchNewsListError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    func filterArticles(with newsList: NewsList, text: String) {
        var wrappedNewsList = newsList
        wrappedNewsList.articles = newsList.articles?.filter {
            let formattedText = text.lowercased()
            
            return $0.title.lowercased().contains(formattedText) || $0.description.lowercased().contains(formattedText)
        }
        
        output?.didFilter(newsList: wrappedNewsList)
    }
}
