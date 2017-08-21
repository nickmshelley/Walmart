//
//  NetworkController.swift
//  Walmart

import Foundation
import UIKit

struct NetworkController {
    static func getProducts(page: Int, completion: @escaping ([Product]) -> Void) {
        let pageSize = 15
        guard let url = URL(string: "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/walmartproducts/e62b524f-4a34-403b-a65c-50cfdd487f46/\(page * pageSize)/\(pageSize)") else {
            print("Failed to create URL")
            return completion([])
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let productsJSON = json?["products"] as? [[String: Any]]
                else {
                    print("Failed to get json: \(String(describing: error))")
                    completion([])
                    return
                }
            
            let products: [Product] = productsJSON.flatMap { productJSON in
                guard let id = productJSON["productId"] as? String,
                    let name = productJSON["productName"] as? String,
                    let shortDescription = productJSON["shortDescription"] as? String,
                    let longDescription = productJSON["longDescription"] as? String,
                    let price = productJSON["price"] as? String,
                    let imageURLString = productJSON["productImage"] as? String,
                    let imageURL = URL(string: imageURLString),
                    let reviewRating = productJSON["reviewRating"] as? Float,
                    let reviewCount = productJSON["reviewCount"] as? Int,
                    let inStock = productJSON["inStock"] as? Bool
                    else { return nil }
                
                return Product(id: id, name: name, shortDescription: shortDescription, longDescription: longDescription, price: price, imageURL: imageURL, reviewRating: reviewRating, reviewCount: reviewCount, inStock: inStock)
            }
            
            completion(products)
        }
        
        dataTask.resume()
    }
    
    static func getImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data,
                let image = UIImage(data: data)
                else {
                    print("Failed to get image: \(String(describing: error))")
                    completion(nil)
                    return
                }
            
            completion(image)
        }
        
        dataTask.resume()
    }
}
