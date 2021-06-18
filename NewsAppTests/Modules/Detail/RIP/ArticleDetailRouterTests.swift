//
//  ArticleDetailRouterTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

class ArticleDetailRouterTests: XCTestCase {
    var router: ArticleDetailRouter!
    let article = NewsDataFactory.factory.newsListSuccessResponse.entity.articles!.first!
    
    override func setUp() {
        super.setUp()
        let container = ArticleDetailDependencyContainer(article: article)
        router = ArticleDetailRouter(container: container)
    }

    func test_TopVCIsNewsListVCWhenPopBack() {
        router.popBack()
        
        XCTAssertTrue(router.container.viewController.topNavController?.viewControllers.last is NewsListViewController)
    }
}
