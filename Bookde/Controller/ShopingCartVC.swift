//
//  ShopingCartVC.swift
//  Bookde
//
//  Created by Apple on 6/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase

class ProductVC: UIViewController {
    
    
    @IBOutlet weak var productTableView: UITableView!
    // variable
    var products = [Product]()
    var category:Category!
    var db:Firestore!
    var listener:ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        
//        setupQuery()
        
        productTableView.delegate = self
        productTableView.dataSource =  self
        productTableView.register(UINib(nibName: Identifiers.CartItemCell, bundle: nil), forCellReuseIdentifier: Identifiers.CartItemCell)
        
        productTableView.rowHeight = UITableView.automaticDimension
        productTableView.estimatedRowHeight = 200

    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismissDetail()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupQuery()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productTableView.reloadData()
    }
    
    
    
    func setupQuery()  {
        
        let collectionReference =  db.products(category: category.id)

        
        listener = collectionReference.addSnapshotListener({ (query, error) in
            
            if let error = error{
                debugPrint(error.localizedDescription)
            }
            query?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type{
                
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductVC:UITableViewDelegate,UITableViewDataSource{
    
    func onDocumentAdded(change:DocumentChange,product:Product)  {
        
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        productTableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)

    
        
    }
    
    func onDocumentModified(change: DocumentChange, product: Product) {
        if change.oldIndex == change.newIndex {
            // Item changed, but remained in the same position
            let index = Int(change.newIndex)
            products[index] = product
            productTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            // Item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            productTableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        productTableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CartItemCell, for: indexPath) as? CartCell else {
            return CartCell()
        }
        
        cell.configureCell(product: products[indexPath.row])
        cell.productTitle.numberOfLines = 0
        cell.productDescription.numberOfLines = 3
//        cell.configureCell(product: product)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        let selectedProduct = products[indexPath.row]
        vc.product = selectedProduct
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    



}
