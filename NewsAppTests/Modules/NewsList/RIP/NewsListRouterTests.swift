//
//  NewsListRouterTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

class NewsListRouterTests: XCTestCase {
    var router: NewsListRouter!

    override func setUp() {
        super.setUp()
        router = NewsListRouter(container: NewsListDependencyContainer())
    }

    func test_TopVCIsArticleDetailVCWhenPresented() {
        let article = NewsDataFactory.factory.newsListSuccessResponse.entity.articles?.first
        router.routeToDetail(article: article!)
        
        XCTAssertTrue(router.container.viewController.topNavController?.viewControllers.last is ArticleDetailViewController)
    }
}
