//
//  fontUtils.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import Foundation
import UIKit

extension String {
    func getHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
