//
//  NewsRemoteDataSourceTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
import Moya
import RxSwift

@testable import NewsApp

class NewsRemoteDataSourceTests: XCTestCase {
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    func test_getNewsListAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "news_success", type: type(of: self)) else {
            XCTFail("Data doesn't has on local")
            return
        }
        
        let provider = MockMoyaProvider<NewsAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = NewsRemoteDataSourceImpl(provider: provider)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        let request = NewsDataFactory.factory.getNewsListRequest(startDate: startDate,
                                                                 endDate: endDate,
                                                                 size: 10,
                                                                 page: 1)
        
        
        remoteDataSource
            .fetchNews(request: request)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertEqual(newList.articles?.count, 2)
                XCTAssertEqual(provider.countOfCallRequest, 1)
            })
            .disposed(by: disposeBag)
    }
    
    func test_getNewsListAPIFailure() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "news_failure", type: type(of: self)) else {
            XCTFail("Data doesn't has on local")
            return
        }
        
        let provider = MockMoyaProvider<NewsAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = NewsRemoteDataSourceImpl(provider: provider)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        let request = NewsDataFactory.factory.getNewsListRequest(startDate: startDate,
                                                                 endDate: endDate,
                                                                 size: 10,
                                                                 page: 1)
        
        
        remoteDataSource
            .fetchNews(request: request)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertNil(newList.articles)
                XCTAssertEqual(provider.countOfCallRequest, 1)
            })
            .disposed(by: disposeBag)
    }
    
    func test_getNewsListAPIError() {
        //arrange
        let error = NewsDataFactory.factory.error
        
        let provider = MockMoyaProvider<NewsAPI>(endpointClosure: {
            $0.endpointForAPI(response: .networkError(error as NSError))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = NewsRemoteDataSourceImpl(provider: provider)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        let request = NewsDataFactory.factory.getNewsListRequest(startDate: startDate,
                                                                 endDate: endDate,
                                                                 size: 10,
                                                                 page: 1)
        
        
        remoteDataSource
            .fetchNews(request: request)
            .subscribe(onError: { (error) in
                //assert
                XCTAssertNotNil(error)
            })
            .disposed(by: disposeBag)
    }
}
