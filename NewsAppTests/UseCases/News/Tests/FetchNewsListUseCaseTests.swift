//
//  FetchNewsListUseCaseTests.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import XCTest
import RxSwift
@testable import NewsApp

class FetchNewsListUseCaseTests: XCTestCase {
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockNewsRepositoryImpl(result: .success)
        let useCase = FetchNewsListUseCaseImpl(repository: repository)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        useCase
            .execute(from: startDate,
                     to: endDate,
                     size: 10,
                     page: 1)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertEqual(newList.articles?.count, 2)
            })
            .disposed(by: disposeBag)
    }
    
    func test_executeFailure() {
        //arrange
        let repository = MockNewsRepositoryImpl(result: .failure)
        let useCase = FetchNewsListUseCaseImpl(repository: repository)
        
        //act
        let date = Date()
        let startDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        let endDate = date.toString(by: Date.YYYYDashMMDashddFormat)
        
        useCase
            .execute(from: startDate,
                     to: endDate,
                     size: 10,
                     page: 1)
            .subscribe(onNext: { (newList) in
                //assert
                XCTAssertNotNil(newList)
                XCTAssertNil(newList.articles)
            })
            .disposed(by: disposeBag)
    }
}
