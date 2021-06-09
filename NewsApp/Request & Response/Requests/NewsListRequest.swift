//
//  NewsListRequest.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

struct NewsListRequest: Requestable {
    var config: Config {
        return .default
    }
    
    let startDate: String
    let endDate: String
    let size: Int
    let page: Int
}
