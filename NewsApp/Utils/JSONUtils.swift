//
//  JSONUtils.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//

import Foundation

class JSONUtils {
    private init() {}
    
    static func loadJson<T>(bundle: Bundle, name: String) -> T? {
        guard let path = bundle.path(forResource: name, ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
            return json as? T
        } catch let error {
            print("parse error: \(error.localizedDescription)")
            return nil
        }
    }
}
