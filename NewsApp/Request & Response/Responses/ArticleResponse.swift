//
//  ArticleResponse.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

struct ArticleResponse: Decodable {
    var source: SourceResponse?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

//MARK: Transform
extension ArticleResponse {
    var entity: Article {
        return Article(source: source?.entity ?? Source(),
                       author: author ?? "",
                       title: title ?? "",
                       description: description ?? "",
                       url: url ?? "",
                       urlToImage: urlToImage ?? "",
                       publishedAt: publishedAt ?? "",
                       content: content ?? "")
    }
}
