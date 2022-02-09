//
//  ArticlesPresenter.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import Foundation

protocol ArticlesPresenterDelegate: AnyObject {
    func updateTableView()
    func showIndicator(animate: Bool)
}

class ArticlesPresenter {
    weak var delegate: ArticlesPresenterDelegate?
    var articles = [Article]()
    
    
    private func fetchArticles() {
        delegate?.showIndicator(animate: true)
        ApiManager.shared.fetchArticles(onSuccess: { [weak self] articles in
            self?.delegate?.showIndicator(animate: false)
            self?.articles = articles
            self?.delegate?.updateTableView()
        }, onError: {[weak self] error in
            self?.delegate?.showIndicator(animate: false)
        })
    }
    
    func articlesVcWillAppear() {
        fetchArticles()
    }
    
    func appWillEnterForeGround() {
        fetchArticles()
    }
}
