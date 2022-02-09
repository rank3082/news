//
//  ArticlesViewController.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let presenter = ArticlesPresenter()
    
    private let titleFontSize: CGFloat = 17
    private let titleLeftMargin: CGFloat = 8
    private let titleRightMargin: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.articlesVcWillAppear()
    }

        
    @objc func appWillEnterForeground() {
        presenter.appWillEnterForeGround()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ArticlesViewController: ArticlesPresenterDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showIndicator(animate: Bool) {
        if animate {
            activityIndicator.startAnimating()
            return
        }
        activityIndicator.stopAnimating()
    }
    
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier) as! ArticleCell
        cell.fill(article: presenter.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { fatalError() }
        webViewController.webUrl = presenter.articles[indexPath.row].url
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let titleSideMargin = titleLeftMargin + titleRightMargin
        let titleLabelWidth = view.bounds.width - titleSideMargin
        let titleLabelHeight = presenter.articles[indexPath.row].title.getHeight(width: titleLabelWidth, font: UIFont.systemFont(ofSize: titleFontSize)) + titleSideMargin
        return titleLabelHeight
    }
}
