//
//  String+HTML.swift
//  Walmart

import UIKit

extension String {
    func htmlAttributedText(font: UIFont?) -> NSAttributedString? {
        let fontedString = font.flatMap { "<span style=\"font-family: \($0.fontName); font-size: \($0.pointSize)\">\(self)</span>" } ?? self
        let data = fontedString.data(using: .unicode)
        return data.flatMap { try? NSAttributedString(data: $0, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil) }
    }
}
