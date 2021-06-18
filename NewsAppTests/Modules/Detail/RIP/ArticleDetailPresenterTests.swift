//
//  ArticleDetailPresenterTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

class ArticleDetailPresenterTests: XCTestCase {
    var presenter: ArticleDetailPresenter!
    let mockInteractor = MockArticleDetailInteractor()
    let mockRouter = MockRouter()
    let mockInterface = MockInterface()
    let article = NewsDataFactory.factory.newsListSuccessResponse.entity.articles!.first!
    
    override func setUp() {
        super.setUp()
        presenter = ArticleDetailPresenter(interactor: mockInteractor,
                                           router: mockRouter,
                                           output: mockInterface)
    }
    
    func test_intialize() {
        //act
        presenter.initialize()
        
        //assert
        XCTAssertNotNil(mockInterface.articleViewModel)
        XCTAssertEqual(mockInterface.articleViewModel?.title, article.title)
        XCTAssertTrue(mockInterface.displayIntializeCalled)
    }
    
    func test_popBack() {
        //act
        presenter.popBack()
        
        //assert
        XCTAssertTrue(mockRouter.popBackCalled)
    }
}

//MARK: Mock
extension ArticleDetailPresenterTests {
    class MockRouter: ArticleDetailRouting {
        var container: ArticleDetailDependencyContainer = ArticleDetailDependencyContainer(article: NewsDataFactory.factory.newsListSuccessResponse.entity.articles!.first!)
        
        var popBackCalled: Bool = false
        
        func popBack() {
            popBackCalled = true
        }
    }
    
    class MockInterface: ArticleDetailPresenterOutput {
        var articleViewModel: ArticleViewModel?
        
        var displayIntializeCalled: Bool = false
        
        func displayIntialize(articleViewModel: ArticleViewModel) {
            self.articleViewModel = articleViewModel
            displayIntializeCalled = true
        }
    }
}
