//
//  ArticleDetailInteractorTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import XCTest
@testable import NewsApp

class ArticleDetailInteractorTests: XCTestCase {
    var subject: ArticleDetailInteractor!
    let article = NewsDataFactory.factory.newsListSuccessResponse.entity.articles!.first!
    
    override func setUp() {
        super.setUp()
        let container = ArticleDetailDependencyContainer(article: article)
        subject = container.interactor
    }

    func test_InteractorReceivesArticleFromRouter() {
        XCTAssertEqual(subject?.article?.title, article.title)
    }
}
