//
//  FetchNewsListUseCase.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation
import RxSwift

protocol FetchNewsListUseCase {
    func fetchNews(from startDate: String, to endDate: String, size: Int, page: Int) -> Observable<NewsList>
}

final class FetchNewsListUseCaseImpl: FetchNewsListUseCase {
    private let repository: NewsRepository
    
    init(repository: NewsRepository = NewsRepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchNews(from startDate: String, to endDate: String, size: Int, page: Int) -> Observable<NewsList> {
        let request = NewsListRequest(startDate: startDate,
                                      endDate: endDate,
                                      size: size,
                                      page: page)
        
        return repository.fetchNews(request: request)
    }
}
