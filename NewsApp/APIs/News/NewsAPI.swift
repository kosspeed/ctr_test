//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation
import Moya

enum NewsAPI {
    case fetchNews(request: NewsListRequest)
}

//MARK: TargetType
extension NewsAPI: TargetType {
    var baseURL: URL {
        guard case NewsAPI.fetchNews(let request) = self, let url = URL(string: request.config.baseURL) else {
            fatalError("Base URL isn't correct.")
        }
        
        return url
    }
    
    var path: String {
        if case NewsAPI.fetchNews = self {
            return "/v2/top-headlines"
        }
        
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        if case NewsAPI.fetchNews(let request) = self {
            let parameters: [String: Any] = [
                "apiKey": request.config.apiToken,
                "from": request.startDate,
                "to": request.endDate,
                "sortBy": "popularity",
                "pageSize": request.size,
                "page": request.page,
                "country": "us"
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
        return .requestPlain
    }
    
    var headers: [String : String]? {
        if case NewsAPI.fetchNews(let request) = self {
            return [
                "X-Api-Key": request.config.apiToken
            ]
        }
        
        return nil
    }
}
