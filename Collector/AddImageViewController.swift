//
//  AddImageViewController.swift
//  Collector
//
//  Created by Pedro Alonso on 6/27/18.
//  Copyright © 2018 Pedro Alonso. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pickerController.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addTapped(_ sender: UIButton) {
    
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let collectable = Collectable(context: context)
            
            collectable.title = self.txtTitle.text
            
            collectable.image = imageView.image?.jpegData(compressionQuality: 1.0)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func folderTapped(_ sender: UIBarButtonItem) {

        pickerController.sourceType = .photoLibrary
//        pickerController.
        
        present(pickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Finish")
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
        dismiss(animated: true, completion: nil)
        
    }
}
