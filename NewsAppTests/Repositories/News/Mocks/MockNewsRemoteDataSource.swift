//
//  MockNewsRemoteDataSource.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
import RxSwift
@testable import NewsApp

final class MockNewsRemoteDataSourceImpl: NewsRemoteDataSource {
    enum Result {
        case success
        case failure
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func fetchNews(request: NewsListRequest) -> Observable<NewsList> {
        switch self.result {
        case .success:
            return Observable.just(NewsDataFactory.factory.newsListSuccessResponse.entity)
        case .failure:
            return Observable.just(NewsDataFactory.factory.newsListFailureResponse.entity)
        }
    }
}
