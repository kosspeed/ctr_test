//
//  CALayer+Extensions.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 12/3/2564 BE.
//

import UIKit

extension CALayer {
    @discardableResult
    func cornerRadius(radius: CGFloat) -> CALayer {
        cornerRadius = radius
        
        return self
    }
    
    @discardableResult
    func shadow(color: UIColor = .black, opacity: Float = 1, offset: CGSize = .zero, radius: CGFloat = 10) -> CALayer {
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = offset
        shadowRadius = radius
        
        return self
    }
}
