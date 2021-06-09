//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import UIKit

protocol NewsListRouting {
    
}

final class NewsListRouter: NewsListRouting {
    private let container: NewsListDependencyContainer
    
    init(container: NewsListDependencyContainer) {
        self.container = container
    }
}
