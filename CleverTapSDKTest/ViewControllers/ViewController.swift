//
//  ViewController.swift
//  CleverTapSDKTest
//
//  Created by Bhawanisingh Rao on 15/08/24.
//

import UIKit
import DogImageLibrary

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var imageFatch: DogImageFetcher = DogImageFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFatch.delegate = self
        self.prevBtn.isEnabled = false
        imageFatch.getImage {[weak self] image in
            if let image{
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func prevBtnAction(_ sender: Any) {
       let tuple = imageFatch.getPreviousImage()
        DispatchQueue.main.async {
        if let image = tuple.image {
                self.imageView.image = image
            }
            self.prevBtn.isEnabled = tuple.isEnable
        }
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        imageFatch.getNextImage {[weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    if !(self?.prevBtn.isEnabled ?? false) {
                        self?.prevBtn.isEnabled = true
                    }
                }
            
        }
    }
    @IBAction func submitBtnAction(_ sender: Any) {
        if let num = Int(textField.text ?? ""), 0 < num , num < 11 {
            imageFatch.getImage(number: num) {  images in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    print(images?.count ?? 0)
                    if let images,let vc = self.storyboard?.instantiateViewController(identifier: "MoreImagesTableViewController")  as? MoreImagesTableViewController{
                        vc.images = images
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if images?.count ?? 0 > 0{
                        Utils.shared.showErrorPopup(on: self, message: "Somthing went wrong")
                    }
                })
            }
        } else {
            Utils.shared.showErrorPopup(on: self, message: "Enter number between 1 to 10")
        }
        
    }
    
}


extension ViewController: DogImageDelegate{
    func didRecieveError(msg: String) {
        DispatchQueue.main.async {
            Utils.shared.hideLoadingPopup(on: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                Utils.shared.showErrorPopup(on: self, message: msg)
            }
        }
    }
    
    func showHideloader(_ loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                Utils.shared.showLoadingPopup(on: self)
            }else{
                Utils.shared.hideLoadingPopup(on: self)
            }
        }
    }
}

