//
//  ArticleCell.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let identifier = "articleCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    func fill(article: Article) {
        titleLabel.text = article.title
    }

}
