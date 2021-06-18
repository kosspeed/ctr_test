//
//  MockArticleDetailInteractor.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 17/6/2564 BE.
//

import Foundation
@testable import NewsApp

class MockArticleDetailInteractor: ArticleDetailInteraction {
    var article: Article? = NewsDataFactory.factory.newsListSuccessResponse.entity.articles?.first
}
