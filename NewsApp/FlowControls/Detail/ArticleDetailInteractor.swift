//
//  ArticleDetailInteractor.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import Foundation

protocol ArticleDetailInteraction {
    var article: Article? { get set }
}

protocol ArticleDetailInteractorOutput: class {

}

final class ArticleDetailInteractor {
    //MARK: Lifecycle
    weak var output: ArticleDetailInteractorOutput?
    
    var article: Article?
}

//MARK: ArticleDetailInteraction
extension ArticleDetailInteractor: ArticleDetailInteraction {

}


