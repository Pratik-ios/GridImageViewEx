//
//  ViewController.swift
//  GrideImageViewEx
//
//  Created by Pratik on 09/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc = GridImgViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
