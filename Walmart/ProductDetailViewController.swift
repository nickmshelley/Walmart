//
//  DetailViewController.swift
//  Walmart

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var productImageView: UIImageView?
    @IBOutlet var priceAndStockLabel: UILabel?
    @IBOutlet var ratingLabel: UILabel?
    @IBOutlet var shortDescriptionLabel: UILabel?
    @IBOutlet var longDescriptionLabel: UILabel?
    
    let product: Product
    
    init(product: Product) {
        self.product = product
        
        super.init(nibName: "ProductDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Details"
        
        titleLabel?.text = product.name
        shortDescriptionLabel?.attributedText = product.shortDescription.htmlAttributedText(font: shortDescriptionLabel?.font)
        longDescriptionLabel?.attributedText = product.longDescription.htmlAttributedText(font: longDescriptionLabel?.font)
        priceAndStockLabel?.text = product.priceAndStockText
        ratingLabel?.text = product.ratingText
        
        NetworkController.getImage(at: product.imageURL) { image in
            DispatchQueue.main.async {
                self.productImageView?.image = image
            }
        }
    }
}

