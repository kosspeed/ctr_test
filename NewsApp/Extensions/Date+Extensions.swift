//
//  Date+Extensions.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 12/6/2564 BE.
//

import Foundation

extension Date {
    static let YYYYDashMMDashddFormat: String = "YYYY-MM-dd"
    static let mmmddCommaHHmmFormat: String = "MMM dd, HH:mm"
    static let kserviceDateFormat: String = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    func toString(by format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
