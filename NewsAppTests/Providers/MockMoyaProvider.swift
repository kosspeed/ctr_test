//
//  MockMoyaProvider.swift
//  NewsAppTests
//
//  Created by Khwan Siricharoenporn on 26/4/2564 BE.
//

import Foundation
import Moya
@testable import NewsApp

class MockMoyaProvider<T: TargetType>: MoyaProvider<T> {
    var countOfCallRequest: Int = 0
    
    override func request(_ target: Target,
                      callbackQueue: DispatchQueue? = .none,
                      progress: ProgressBlock? = .none,
                      completion: @escaping Completion) -> Cancellable {
        countOfCallRequest += 1
        return super.request(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }
}
