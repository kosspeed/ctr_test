//
//  NewsRemoteDataSource.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation
import RxSwift
import Moya

enum NewsRemoteDataSourceError: Error {
    case serviceIsNotOK
}

protocol NewsRemoteDataSource {
    func fetchNews(request: NewsListRequest) -> Observable<NewsList>
}

final class NewsRemoteDataSourceImpl: NewsRemoteDataSource {
    private let provider: MoyaProvider<NewsAPI>
    
    init(provider: MoyaProvider<NewsAPI> = MoyaProvider<NewsAPI>()) {
        self.provider = provider
    }
    
    func fetchNews(request: NewsListRequest) -> Observable<NewsList> {
        return Observable.create { [weak self] (emitter) -> Disposable in
            guard let self = self else {
                return Disposables.create()
            }
            
            self.provider.requestWithWrappedSerialize(.fetchNews(request: request),
                                                      resposeType: NewsListResponse.self) { (result) in
                switch result {
                case .success(let response):
                    if response.status == "ok" {
                        emitter.onNext(response.entity)
                    } else {
                        emitter.onError(NewsRemoteDataSourceError.serviceIsNotOK)
                    }
                    
                case .failure(let error):
                    emitter.onError(error)
                }
                
                emitter.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
