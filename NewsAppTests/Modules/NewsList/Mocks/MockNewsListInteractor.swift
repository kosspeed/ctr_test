//
//  MockNewsListInteractor.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import Foundation
@testable import NewsApp

class MockNewsListInteractor: NewsListInteraction {
    enum ResultType {
        case success
        case failure
    }
    
    weak var output: NewsListInteractorOutput?
    
    var newsList: NewsList?
    var filteredNewsList: NewsList?
    
    var fetchNewsListCalled: Bool = false
    var filterArticlesCalled: Bool = false
    
    var result: ResultType = .success
    
    func fetchNewsList(from startDate: Date, to endDate: Date, size: Int, page: Int) {
        fetchNewsListCalled = true
        newsList = NewsDataFactory.factory.newsListSuccessResponse.entity
        
        switch result {
        case .success:
            output?.didFetchNewsListSuccess(newsList: newsList!)
        case .failure:
            output?.didFetchNewsListError(error: NewsDataFactory.factory.error)
        }
    }
    
    func filterArticles(with text: String) {
        filterArticlesCalled = true
        filteredNewsList = NewsDataFactory.factory.newsListSuccessResponse.entity
        
        output?.didFilter(newsList: filteredNewsList!)
    }
}
