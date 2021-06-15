//
//  Config.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 9/6/2564 BE.
//

import Foundation

fileprivate let kBaseURLKey: String = "base_url"
fileprivate let kAPIKey: String = "api_key"

struct Config {
    static var `default`: Config = Config()
    
    private(set) var baseURL: String
    private(set) var apiToken: String
    private(set) var backupApiToken: String
    
    init(type: ConfigType = .default) {
        switch type {
        case .default:
            let plist = Bundle.getPlist(forResource: "Config")
            
            baseURL = plist?[kBaseURLKey] as? String ?? ""
            apiToken = plist?[kAPIKey] as? String ?? ""
            backupApiToken = apiToken
        case .customize(let baseURL, let apiToken):
            self.baseURL = baseURL
            self.apiToken = apiToken
            backupApiToken = apiToken
        }
    }
    
    mutating func setRuntimeToken(token: String) {
        apiToken = token
    }
}

//MARK: ConfigType
extension Config {
    enum ConfigType {
        case `default`
        case customize(baseURL: String, apiToken: String)
    }
}
