//
//  NewFeedVC.swift
//  Bookde
//
//  Created by Apple on 5/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

class NewFeedVC: UIViewController {
    
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var foodColectionView: UICollectionView!
  
    let newFeedScrollView:UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .white
      return scrollView
    }()
  
    let contentView = UIView()
      
    @IBOutlet weak var popularFoodCollectionView: UICollectionView!
    // variable
    var categories = [Category]()
    var selectedCategory: Category!
    var db : Firestore!
    var listener:ListenerRegistration!
    


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//            fetchCollection()
        
        setCategoriesListener()
        if let user = Auth.auth().currentUser , !user.isAnonymous {
            // We are logged in
            loginOutBtn.title = "Logout"
          
        } else {
            loginOutBtn.title = "Login"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            db = Firestore.firestore()
            setupCollectionView()

    }
    // Called before view is removed
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        foodColectionView.reloadData()
    }
    
    func setupInitialAnonymousUser() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                    debugPrint(error)
                }
            }
        }
    }
    
    func setupCollectionView()
    {
      
      self.view.addSubview(newFeedScrollView)
      self.newFeedScrollView.addSubview(contentView)
      self.contentView.addSubview(foodColectionView)
      newFeedScrollView.snp.makeConstraints { (make)  in
        
        make.centerX.equalTo(view.center)
        make.width.equalTo(self.view)
        make.top.equalTo(self.view)
        make.bottom.equalTo(self.view)
      }
      
      contentView.snp.makeConstraints { (make) in
        
        make.centerX.equalTo(newFeedScrollView)
        make.width.equalTo(newFeedScrollView)
        make.top.equalTo(newFeedScrollView)
        make.bottom.equalTo(newFeedScrollView)
      }
      
      foodColectionView.snp.makeConstraints { (make) in
        make.top.equalTo(contentView).inset(0)
        make.leading.equalTo(contentView).inset(0)
        make.trailing.equalTo(contentView).inset(0)
        make.height.equalTo(300)
        
      }
      
//        self.foodColectionView.showsHorizontalScrollIndicator = false
//
        foodColectionView.register(UINib.init(nibName: "NewFeedCell", bundle: nil), forCellWithReuseIdentifier: Identifiers.NewFeedCell)
//
        popularFoodCollectionView.register(UINib.init(nibName: "PopularCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
//
//        // layout for collection view
        let width = (view.frame.width)/3
//
        let floawLayout1 = popularFoodCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        floawLayout1.itemSize = CGSize(width: UIScreen.main.bounds.size.width , height: width)
        floawLayout1.scrollDirection = .horizontal


        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: foodColectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        foodColectionView.collectionViewLayout = floawLayout

        setupInitialAnonymousUser()

        
        
    }
    
    func setCategoriesListener(){
        
        listener = db.categories.addSnapshotListener({ (snap, erro) in
            
            if erro != nil{
                debugPrint(erro?.localizedDescription ?? "")
                return
            
            }
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let category = Category.init(data: data)
                switch change.type{
                
                case .added:
                    self.onDocumentAdded(change: change, categoy: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
            
        })
    
    }
    
    func onDocumentAdded(change:DocumentChange,categoy:Category)  {
        
        let newIndex = Int(change.newIndex)
        categories.insert(categoy, at: newIndex)
        foodColectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
        
//        popularFoodCollectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
        
        
    }
    func onDocumentModified(change:DocumentChange,category:Category)  {
        if change.newIndex == change.oldIndex{
            
            let index = Int(change.newIndex)
            categories[index] = category
            foodColectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            
        }else{
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            categories.remove(at: oldIndex)
            categories.insert(category, at: newIndex)
            foodColectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
            
        }
        
        
    }
    func onDocumentRemoved(change:DocumentChange){
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: Int(change.oldIndex))
        foodColectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
        
        
    }
    func fetchDocument(){
        
        
        let docRef = self.db.collection("categories").document("rELJynxcZeEybepz6QLu")
        
        docRef.addSnapshotListener { (snap, error) in
            self.categories.removeAll()

            guard let data =  snap?.data() else {return}
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.foodColectionView.reloadData()
        }
        

        
    
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.Authenticate, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: StorybaordId.LoginVC)

        
        present(controller, animated: true, completion: nil)
    }
    private func enableOffline() {
        // [START enable_offline]
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = false
        // Any additional options
        // ...
        // Enable offline data persistence
        let db = Firestore.firestore()
        db.settings = settings
        // [END enable_offline]
    }
    
    private func fetchCollection(){
      let collectionReference =  db.collection("categories")
        
       listener = collectionReference.addSnapshotListener { (snap, error) in
            guard let document =  snap?.documents else  {return}
            self.categories.removeAll()
            for document in document{
                
                let data = document.data()
                let newCategories =  Category.init(data: data)
                self.categories.append(newCategories)
            }
            self.foodColectionView.reloadData()

            
        }
//        collectionReference.getDocuments { (snap, error) in
//
//            guard let document =  snap?.documents else  {return}
//
//            for document in document{
//
//                let data = document.data()
//                let newCategories =  Category.init(data: data)
//                self.categories.append(newCategories)
//                self.foodColectionView.reloadData()
//            }
//
//        }
    
    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout = self.foodColectionView.collectionViewLayout as! UPCarouselFlowLayout
//        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//    }
//    
//    fileprivate var currentPage: Int = 0 {
//        didSet {
//            print("page at centre = \(currentPage)")
//        }
//    }
//    fileprivate var pageSize: CGSize {
//        let layout = self.foodColectionView.collectionViewLayout as! UPCarouselFlowLayout
//        var pageSize = layout.itemSize
//        if layout.scrollDirection == .horizontal {
//            pageSize.width += layout.minimumLineSpacing
//        } else {
//            pageSize.height += layout.minimumLineSpacing
//        }
//        return pageSize
//    }
    


    @IBAction func loginOutClicked(_ sender: Any) {
    
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                        debugPrint(error)
                    }
                    self.presentLoginController()
                }
            } catch {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint(error)
            }
        }
    }
        
        

    }
    


extension NewFeedVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return 1
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == foodColectionView{
            
            return categories.count
        }
        return DataService.instance.getProduct().count


    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == foodColectionView{
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.NewFeedCell, for: indexPath) as? NewFeedCell else{return NewFeedCell()}
            
            cell.configureCell(category: categories[indexPath.item])

            return cell
        }else{
            guard let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PopularCell else{return PopularCell()}
            
//            cell1.updateView(food: categories[indexPath.item])
            let data = DataService.instance.getProduct()[indexPath.row]
//
            cell1.updateView(food: data)
            return cell1

        }
        
        
        
      
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: Segues.ToProducts, sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.ToProducts{
            if let destination  = segue.destination as? ProductVC{
                destination.category = selectedCategory
                
                
            }
        
        }
    }
    


}
