//
//  RequestConfigable.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

protocol Requestable: Encodable {
    var config: Config { get }
}
