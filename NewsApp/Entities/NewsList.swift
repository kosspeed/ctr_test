//
//  NewsList.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

struct NewsList {
    var totalResults: Int = 0
    var articles: [Article]?
    
    private(set) var size: Int = 10
    private(set) var page: Int = 1
    
    var hasNext: Bool {
        return size * page < totalResults
    }
    
    mutating func nextPage() {
        page += 1
    }
    
    mutating func reset() {
        page = 1
    }
}
