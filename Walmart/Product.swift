//
//  Product.swift
//  Walmart

import Foundation

struct Product {
    let id: String
    let name: String
    let shortDescription: String
    let longDescription: String
    let price: String
    let imageURL: URL
    let reviewRating: Float
    let reviewCount: Int
    let inStock: Bool
    
    var priceAndStockText: String {
        let stockText = inStock ? "In Stock" : "Out of Stock"
        return "\(price) (\(stockText))"
    }
    
    var ratingText: String {
        return reviewCount > 0 ? String(format: "Rated %.1f (\(reviewCount) reviews)", reviewRating) : "No reviews"
    }
}
