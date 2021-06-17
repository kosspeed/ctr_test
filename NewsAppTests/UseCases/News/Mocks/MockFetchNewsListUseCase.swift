//
//  MockFetchNewsListUseCase.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
import RxSwift
@testable import NewsApp

class MockFetchNewsListUseCaseImpl: FetchNewsListUseCase {
    enum Result {
        case success
        case failure
        case error
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    func execute(from startDate: String, to endDate: String, size: Int, page: Int) -> Observable<NewsList> {
        switch self.result {
        case .success:
            return Observable.just(NewsDataFactory.factory.newsListSuccessResponse.entity)
        case .failure:
            return Observable.just(NewsDataFactory.factory.newsListFailureResponse.entity)
        case .error:
            return Observable.error(NewsDataFactory.factory.error)
        }
    }
}
