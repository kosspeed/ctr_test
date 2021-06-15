//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 13/6/2564 BE.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var updatedLabel: UILabel!
}

//MARK: Configure
extension NewsTableViewCell {
    func configure(article: ArticleViewModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        updatedLabel.text = article.updatedAt
        thumbnailImageView.kf.setImage(with: article.imageURL,
                                       placeholder: article.placeholderImage,
                                       options: [.transition(.fade(1))])
    }
}
