//
//  AddEditCategoryVC.swift
//  BookdeAdmin
//
//  Created by Apple on 6/29/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
class AddEditCategoryVC: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    
    
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBAction func addCategoryClicked(_ sender: Any) {
        
        activityIndicator.startAnimating()
        uploadImageThenDocument()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTaped(_tap:)))
        tap.numberOfTapsRequired = 1
        categoryImage.isUserInteractionEnabled = true
        categoryImage.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    @objc func imageTaped(_tap:UITapGestureRecognizer){
        
        lauchImagePicker()
        
    }
    
    func uploadImageThenDocument()
    {
        guard let image = categoryImage.image,let categoryName = nameTxt.text,categoryName.isNotEmpty else {
            
            simpleAlert(title: "Error", msg: "Must add category image and name")
            return
        }
    
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            return
        }
        let imageRef = Storage.storage().reference().child("/categoryName/\(categoryName).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            
            if let error = error{
                debugPrint("error\(error)")
                self.simpleAlert(title: "Error", msg: "Unable to upload image")
                self.activityIndicator.stopAnimating()
                return
            }
            
            imageRef.downloadURL(completion: { (url, error) in
                
                
                if let error = error {
                    debugPrint("error\(error)")
                    self.simpleAlert(title: "Error", msg: "Unable to upload image")
                    self.activityIndicator.stopAnimating()
                    return
                }
                guard let url = url else {return }
                print(url)
                self.uploadDocument(url: url.absoluteString)

                
            })
        }
        
        
    }
    func uploadDocument(url:String){
        
        var docRef:DocumentReference!
        var category = Category.init(brand: nameTxt.text ?? "",
                                     id:"121122" ,
                                     imageUrl: url,
                                     isActive: true,
                                     timeStamp: Timestamp(),
                                     description: descriptionTxt.text ?? "",
                                     price: 3.0)
        
        
        
        docRef = Firestore.firestore().collection("categories").document()
        
        category.id = docRef.documentID
        let data = Category.modelToData(category: category)
        
        docRef.setData(data, merge: true) { (error) in
            
            if let error = error {
                self.handleError(error: error, msg: "Unable to upload new category to FireStore")
                return
            }
            self.navigationController?.popViewController(animated: true)
        
        }
        
      
    }
    
    
    func handleError(error:Error,msg:String){
        
        debugPrint("error\(error)")
        self.simpleAlert(title: "Error", msg: msg )
        self.activityIndicator.stopAnimating()
        return
        
        
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
extension AddEditCategoryVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func lauchImagePicker(){
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.image = image
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissDetail()
    }


}
