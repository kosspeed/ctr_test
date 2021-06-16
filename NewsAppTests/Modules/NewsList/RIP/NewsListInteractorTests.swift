//
//  NewsListInteractorTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

final class NewsListInteractorTests: XCTestCase {
    var subject: NewsListInteractor!
    var output: FakeInteractorOutput = FakeInteractorOutput()

    override func setUp() {
        super.setUp()
        output = FakeInteractorOutput()
    }
    
    func test_fetchNewsListSuccess() {
        //arrange
        let currentDate = Date()
        let useCase = MockFetchNewsListUseCaseImpl(result: .success)
        subject = NewsListInteractor(fetchNewsListUseCase: useCase)
        subject.output = output
        
        //act
        subject.fetchNewsList(from: currentDate,
                              to: currentDate,
                              size: 10,
                              page: 1)
        
        //assert
        XCTAssertNotNil(output.newsList)
        XCTAssertEqual(output.newsList?.articles?.count, 2)
    }
    
    func test_fetchNewsListFailure() {
        //arrange
        let currentDate = Date()
        let useCase = MockFetchNewsListUseCaseImpl(result: .failure)
        subject = NewsListInteractor(fetchNewsListUseCase: useCase)
        subject.output = output
        
        //act
        subject.fetchNewsList(from: currentDate,
                              to: currentDate,
                              size: 10,
                              page: 1)
        
        //assert
        XCTAssertNotNil(output.newsList)
        XCTAssertNil(output.newsList?.articles)
    }
    
    func test_fetchNewsListError() {
        //arrange
        let currentDate = Date()
        let useCase = MockFetchNewsListUseCaseImpl(result: .error)
        subject = NewsListInteractor(fetchNewsListUseCase: useCase)
        subject.output = output
        
        //act
        subject.fetchNewsList(from: currentDate,
                              to: currentDate,
                              size: 10,
                              page: 1)
        
        //assert
        XCTAssertNotNil(output.error)
    }
    
    func test_filterArticlesInCaseTitle() {
        //arrange
        let newsList = NewsDataFactory.factory.newsListSuccessResponse.entity
        subject = NewsListInteractor()
        subject.newsList = newsList
        subject.output = output
        
        //act
        subject.filterArticles(with: "dangerous")
        
        //assert
        XCTAssertNotNil(output.filteredNewsList)
        
        let articles = output.filteredNewsList?.articles ?? []
        XCTAssertEqual(articles.count, 1)
    }
    
    func test_filterArticlesInCaseContent() {
        //arrange
        let newsList = NewsDataFactory.factory.newsListSuccessResponse.entity
        subject = NewsListInteractor()
        subject.newsList = newsList
        subject.output = output
        
        //act
        subject.filterArticles(with: "coronavirus")
        
        //assert
        XCTAssertNotNil(output.filteredNewsList)
        
        let articles = output.filteredNewsList?.articles ?? []
        XCTAssertEqual(articles.count, 1)
    }
}

//MARK:
extension NewsListInteractorTests {
    class FakeInteractorOutput: NewsListInteractorOutput {
        var newsList: NewsList?
        var filteredNewsList: NewsList?
        var error: Error?
        
        func didFetchNewsListSuccess(newsList: NewsList) {
            self.newsList = newsList
        }
        
        func didFetchNewsListError(error: Error) {
            self.error = error
        }
        
        func didFilter(newsList: NewsList) {
            self.filteredNewsList = newsList
        }
    }
}
