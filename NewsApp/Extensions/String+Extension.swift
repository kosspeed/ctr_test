//
//  String+Extension.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import Foundation

extension String {
    func dateStringToString(with currentlyFormat: String, to expectFormat: String) -> String? {
        /* Currently */
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = currentlyFormat
        
        guard let currentlyDate = formatter.date(from: self) else { return nil }
        
        /* Expect */
        formatter.dateFormat = expectFormat
        
        let expectDate = formatter.string(from: currentlyDate)
        
        return expectDate
    }
}
