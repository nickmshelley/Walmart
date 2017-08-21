//
//  ProductCell.swift
//  Walmart


import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var productImageView: UIImageView?
    @IBOutlet var shortDescriptionLabel: UILabel?
    @IBOutlet var priceAndStockLabel: UILabel?
    @IBOutlet var ratingLabel: UILabel?
    
    override func awakeFromNib() {
        // This clutters things on the phone
        shortDescriptionLabel?.isHidden = UIDevice.current.userInterfaceIdiom != .pad
    }
    
    func configure(withProduct product: Product) {
        accessoryType = .disclosureIndicator
        nameLabel?.text = product.name
        shortDescriptionLabel?.attributedText = product.shortDescription.htmlAttributedText(font: shortDescriptionLabel?.font)
        priceAndStockLabel?.text = product.priceAndStockText
        ratingLabel?.text = product.ratingText
        
        NetworkController.getImage(at: product.imageURL) { image in
            DispatchQueue.main.async {
                self.productImageView?.image = image
            }
        }
    }
}
