//
//  NewsRepositoryTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
import RxSwift
@testable import NewsApp

class NewsRepositoryTests: XCTestCase {
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    func test_getNewsListSuccess() {
        //arrange
        let remoteDataSource = MockNewsRemoteDataSourceImpl(result: .success)
        let repository = NewsRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        let request = NewsDataFactory.factory.getNewsListRequest(startDate: startDate,
                                                                 endDate: endDate,
                                                                 size: 10,
                                                                 page: 1)
        
        
        repository
            .fetchNews(request: request)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertEqual(newList.articles?.count, 2)
            })
            .disposed(by: disposeBag)
    }
    
    func test_getNewsListFailure() {
        //arrange
        let remoteDataSource = MockNewsRemoteDataSourceImpl(result: .failure)
        let repository = NewsRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        let request = NewsDataFactory.factory.getNewsListRequest(startDate: startDate,
                                                                 endDate: endDate,
                                                                 size: 10,
                                                                 page: 1)
        
        
        repository
            .fetchNews(request: request)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertNil(newList.articles)
            })
            .disposed(by: disposeBag)
    }
}
