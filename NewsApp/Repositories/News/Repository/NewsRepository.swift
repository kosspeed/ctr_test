//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation
import Moya
import RxSwift

protocol NewsRepository {
    func fetchNews(request: NewsListRequest) -> Observable<NewsList>
}

final class NewsRepositoryImpl: NewsRepository {
    private let remoteDataSource: NewsRemoteDataSource
    
    init(remoteDataSource: NewsRemoteDataSource = NewsRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchNews(request: NewsListRequest) -> Observable<NewsList> {
        return remoteDataSource.fetchNews(request: request)
    }
}
