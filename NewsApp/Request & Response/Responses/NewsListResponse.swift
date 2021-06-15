//
//  NewsListResponse.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

struct NewsListResponse: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleResponse]?
}

//MARK: Transform
extension NewsListResponse {
    var entity: NewsList {
        return NewsList(totalResults: totalResults ?? 0,
                        articles: articles?.map { $0.entity })
    }
}
