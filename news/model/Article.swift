//
//  Article.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import Foundation

struct Article: Codable {
    var author: String?
    let title: String
    let url: String
}
