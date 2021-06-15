//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 15/6/2564 BE.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var updatedLabel: UILabel!
    
    var presenter: ArticleDetailPresentation?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        initialize()
    }
}

//MARK: Setup
private extension ArticleDetailViewController {
    func setup() {
        self.title = "Details"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .customGreen
        navigationController?.navigationBar.tintColor = .white
        
        setupBackButton()
    }
    
    func setupBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_left_chevron"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: Logics
private extension ArticleDetailViewController {
    func initialize() {
        presenter?.initialize()
    }
}

//MARK: ArticleDetailPresenterOutput
extension ArticleDetailViewController: ArticleDetailPresenterOutput {
    func displayIntialize(articleViewModel: ArticleViewModel) {
        titleLabel.text = articleViewModel.title
        contentLabel.text = articleViewModel.description
        updatedLabel.text = articleViewModel.updatedAt
        thumbnailImageView.kf.setImage(with: articleViewModel.imageURL,
                                       placeholder: articleViewModel.placeholderImage,
                                       options: [.transition(.fade(1))])
    }
}

//MARK: Selector
extension ArticleDetailViewController {
    @objc func back() {
        presenter?.popBack()
    }
}
