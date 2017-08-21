//
//  ProductsTableViewController.swift
//  Walmart

import UIKit

private enum Section: Int {
    case products
    case loadMore
}

class ProductsTableViewController: UITableViewController {
    private let productCellReuseIdentifier = "ProductCell"
    private let loadingCellReuseIdentifier = "LoadingCell"
    
    var products = [Product]()
    var hasMoreProducts = true
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: productCellReuseIdentifier)
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: loadingCellReuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) ?? .loadMore {
        case .products:
            return products.count
        case .loadMore:
            return hasMoreProducts ? 1 : 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) ?? .loadMore {
        case .products:
            guard let productCell = tableView.dequeueReusableCell(withIdentifier: productCellReuseIdentifier, for: indexPath) as? ProductCell else { return UITableViewCell() }
            
            let product = products[indexPath.row]
            productCell.configure(withProduct: product)
            return productCell
        case.loadMore:
            guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: loadingCellReuseIdentifier, for: indexPath) as? LoadMoreCell else { return UITableViewCell() }
            
            loadingCell.selectionStyle = .none
            loadingCell.activityIndicator?.startAnimating()
            loadMoreProducts()
            return loadingCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) ?? .loadMore {
        case .products:
            let detailViewController = ProductDetailViewController(product: products[indexPath.row])
            navigationController?.pushViewController(detailViewController, animated: true)
        case.loadMore:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func loadMoreProducts() {
        NetworkController.getProducts(page: currentPage) { products in
            DispatchQueue.main.async {
                if products.isEmpty {
                    self.hasMoreProducts = false
                } else {
                    self.currentPage += 1
                    self.products += products
                }
                
                self.tableView.reloadData()
            }
        }
    }
}
