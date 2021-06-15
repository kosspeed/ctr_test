//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Khwan Siricharoenporn on 10/6/2564 BE.
//

import UIKit

class NewsListViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: UIView!
    
    var presenter: NewsListPresentation?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setup()
        fetchNewsList(nextPage: false)
    }
    
    @IBAction private func didTappedEmptyView(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
}

//MARK: Setup
private extension NewsListViewController {
    func setup() {
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.register(NewsTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

//MARK: Logic
private extension NewsListViewController {
    func initialize() {
        presenter?.initialize()
    }
    
    func fetchNewsList(nextPage: Bool) {
        presenter?.fetchNewsList(nextPage: nextPage)
    }
    
    func filterArticles(text: String) {
        presenter?.filterArticles(by: text)
    }
    
    func resetFilterState() {
        presenter?.resetFilterState()
    }
}

//MARK: NewsListPresenterInterface
extension NewsListViewController: NewsListPresenterOutput {
    func displayIntialize(title: String,
                          titleAttributes: [NSAttributedString.Key : Any],
                          navigationBarColor: UIColor) {
        self.title = title
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.barTintColor = navigationBarColor
    }
    
    func displayNewsList() {
        guard let isEmpty = presenter?.isEmpty else { return }
        
        emptyView.isHidden = !isEmpty
        tableView.reloadData()
    }
    
    func displayError(message: String) {
        
    }
}

//MARK: UISearchBarDelegate
extension NewsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArticles(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetFilterState()
    }
}

//MARK: UITableViewDataSource & UITableViewDelegate
extension NewsListViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: NewsTableViewCell.self, for: indexPath)
        
        guard let article = presenter?.articleViewModel(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            guard let presenter = self.presenter else { return }
            
            if presenter.hasNext, !presenter.isLoading {
                fetchNewsList(nextPage: true)
            }
        }
    }
}
