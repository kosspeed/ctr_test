//
//  SourceResponse.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

struct SourceResponse: Decodable {
    var id: String?
    var name: String?
}

//MARK: Transform
extension SourceResponse {
    var entity: Source {
        return Source(id: id ?? "",
                      name: name ?? "")
    }
}
