//
//  NewsDataFactory.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
@testable import NewsApp

class NewsDataFactory {
    static let factory: NewsDataFactory = NewsDataFactory()
    
    private init() {}
    
    func getNewsListRequest(startDate: String,
                            endDate: String,
                            size: Int,
                            page: Int) -> NewsListRequest {
        
        return NewsListRequest(startDate: startDate,
                               endDate: endDate,
                               size: size,
                               page: page)
    }
    
    var newsListSuccessResponse: NewsListResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "news_success", type: type(of: self))
        let decoded = try! JSONDecoder().decode(NewsListResponse.self, from: data!)
        return decoded
    }
    
    var newsListFailureResponse: NewsListResponse {
        let data = Bundle.loadDataInJSONFile(fileName: "news_failure", type: type(of: self))
        let decoded = try! JSONDecoder().decode(NewsListResponse.self, from: data!)
        return decoded
    }
    
    var error: Error {
        return NSError(domain: "", code: 500, userInfo: [:])
    }
}
