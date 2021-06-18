//
//  Bundle+Extensions.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

extension Bundle {
    static func getPlist(inBundle bundle: Bundle = .main,
                         forResource resource: String) -> [String: Any]? {
        guard let path = bundle.path(forResource: resource, ofType: "plist") else {
            return nil
        }
        
        return NSDictionary(contentsOfFile: path) as? [String: Any]
    }
    
    static func plistValue(inBundle bundle: Bundle = .main,
                           forResource resource: String,
                           forKey key: String) -> Any? {
        guard let resource = getPlist(inBundle: bundle, forResource: resource) else {
            return nil
        }
        
        return resource[key]
    }
    
    static func loadDataInJSONFile(fileName: String, type: AnyClass) -> Data? {
        let bundle = Bundle(for: type)
        guard let filePath = bundle.path(forResource: fileName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            return nil
        }
        return data
    }
}
