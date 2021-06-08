////
////  Moya+Extensions.swift
////  NewsApp
////
////  Created by Khwan Siricharoenporn on 10/3/2564 BE.
////
//
//import Foundation
//import Moya
//
//extension MoyaProvider {
//    func requestWithWrappedSerialize<T: Decodable>(_ target: Target,
//                                                   resposeType: T.Type,
//                                                   completion: @escaping (Result<T, CurrencyError>) -> Void) {
//        request(target) { (result) in
//            switch result {
//            case .success(let response):
//                do {
//                    let wrappedResponse = try response.data.jsonTo(type: resposeType)
//                    completion(.success(wrappedResponse))
//                } catch (let error) {
//                    completion(.failure(.defaultError(message: error.localizedDescription)))
//                }
//            case .failure(let error):
//                let apiError = try? error.response?.data.jsonTo(type: CurrencyErrorResponse.self)
//                let wrappedError = apiError?.entity ?? .defaultError(message: error.localizedDescription)
//
//                completion(.failure(wrappedError))
//            }
//        }
//    }
//}
//
//extension TargetType {
//    func endpointForAPI(response: EndpointSampleResponse) -> Endpoint {
//        return Endpoint(url: baseURL.absoluteString,
//                        sampleResponseClosure: { response },
//                        method: method,
//                        task: task,
//                        httpHeaderFields: headers)
//    }
//}
//
//
