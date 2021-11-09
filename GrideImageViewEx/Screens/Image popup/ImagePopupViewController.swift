//
//  ImagePopupViewController.swift
//  GrideImageViewEx
//
//  Created by Pratik on 09/11/21.
//

import UIKit

class ImagePopupViewController: UIViewController, XIBed {
    @IBOutlet weak var imgViewRef: UIImageView!
    @IBOutlet weak var nextBtnRef: UIButton!
    @IBOutlet weak var beforeBtnRef: UIButton!
    @IBOutlet weak var viewRef: UIView!
    
    var imgUrl = ""
    var imagesArr: ImagesAPIResponse = []
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "no-image-available"))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.cancelsTouchesInView = false
        viewRef.addGestureRecognizer(tapGesture)
    }

    @objc func dismissView(){
        dismiss(animated: true, completion: nil)
    }

}

//MARK:- Button Action
extension ImagePopupViewController {
    @IBAction func nextBtnTap(_ sender: UIButton) {
        if imagesArr.count != currentIndex {
        currentIndex = currentIndex + 1
        if let image = imagesArr[currentIndex].hdurl {
            imgViewRef.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "no-image-available"))

        }
        }
    }
    
    @IBAction func beforeBtnTap(_ sender: UIButton) {
        if currentIndex != 0 {
        currentIndex = currentIndex - 1
        if let image = imagesArr[currentIndex].hdurl {
            imgViewRef.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "no-image-available"))

        }
        }

    }
}
