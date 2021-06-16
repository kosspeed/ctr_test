//
//  NewsListPresenterTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

class NewsListPresenterTests: XCTestCase {
    var presenter: NewsListPresenter!
    let mockInteractor = MockNewsListInteractor()
    let mockRouter = MockRouter()
    var mockInterface = MockInterface()
    
    override func setUp() {
        super.setUp()
        presenter = NewsListPresenter(interactor: mockInteractor,
                                      router: mockRouter,
                                      output: mockInterface)
        
        mockInteractor.output = presenter
    }

    func test_fetchNewsList() {
        //act
        presenter?.fetchNewsList(nextPage: true)
        
        //assert
        XCTAssertEqual(presenter.sections, 1)
        XCTAssertEqual(presenter.numberOfRows, 2)
        XCTAssertTrue(presenter.hasNext)
        XCTAssertFalse(presenter.isEmpty)
        XCTAssertTrue(presenter.isLoading)
        
        let article = presenter.article(at: 0)
        XCTAssertEqual(article?.title, "Covid-19 News: Live Updates - The New York Times")
        
        let articleViewModel = presenter.articleViewModel(at: 0)
        XCTAssertEqual(articleViewModel?.title, "Covid-19 News: Live Updates - The New York Times")

        XCTAssertTrue(mockInterface.displayNewsListCalled)
    }
    
    func test_fetchNewsListError() {
        //arrange
        mockInteractor.result = .failure
        
        //act
        presenter?.fetchNewsList(nextPage: true)
        
        //assert
        XCTAssertTrue(mockInterface.displayErrorCalled)
    }
    
    func test_filterArticles() {
        //act
        presenter?.filterArticles(by: "Covid-19")
        
        //assert
        XCTAssertEqual(presenter.sections, 1)
        XCTAssertTrue(presenter.isFiltering)
        XCTAssertFalse(presenter.hasNext)
        XCTAssertFalse(presenter.isEmpty)
        
        let article = presenter.article(at: 0)
        XCTAssertEqual(article?.title, "Covid-19 News: Live Updates - The New York Times")
        
        let articleViewModel = presenter.articleViewModel(at: 0)
        XCTAssertEqual(articleViewModel?.title, "Covid-19 News: Live Updates - The New York Times")
        
        XCTAssertTrue(mockInterface.displayNewsListCalled)
    }
    
    func test_filterArticlesEmptyTest() {
        //act
        presenter?.filterArticles(by: "")
        
        //assert
        XCTAssertFalse(presenter.isFiltering)
    }
    
    func test_resetFilterState() {
        //act
        presenter?.resetFilterState()
        
        //assert
        XCTAssertFalse(presenter.isFiltering)
    }
    
    func test_select() {
        //arrange
        let article = NewsDataFactory.factory.newsListSuccessResponse.entity.articles?.first
        
        //act
        presenter.select(article: article!)
        
        //assert
        XCTAssertEqual(mockRouter.article?.title, article?.title)
    }
}

//MARK: Mock
extension NewsListPresenterTests {
    class MockRouter: NewsListRouting {
        var container: NewsListDependencyContainer = NewsListDependencyContainer()
        var article: Article?
        
        func routeToDetail(article: Article) {
            self.article = article
        }
    }
    
    class MockInterface: NewsListPresenterOutput {
        var displayNewsListCalled: Bool = false
        var displayErrorCalled: Bool = false
        
        func displayNewsList() {
            displayNewsListCalled = true
        }
        
        func displayError(message: String) {
            displayErrorCalled = true
        }
    }
}
