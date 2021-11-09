//
//  GridImgViewController.swift
//  GrideImageViewEx
//
//  Created by Pratik on 09/11/21.
//

import UIKit
import Alamofire

class GridImgViewController: UIViewController, XIBed {
    @IBOutlet weak var collectionViewRef: UICollectionView!
    
    private lazy var gridImageViewCollectionViewManager = { GridImageViewCollectionViewManager() }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

}

//MARK:- SetupUI
extension GridImgViewController {
    func setupUI(){
        
        gridImageViewCollectionViewManager.presentDelegate = self
        
        getImagesApi()
        
    }
}

//MARK:- Present Delegate
extension GridImgViewController: presentViewControllersDelegate{
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

//MARK:- Api Call
extension GridImgViewController {
    func getImagesApi(){
        let headers : HTTPHeaders = [
            "Content-Type" : "application/json"
        ]


        let url = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=42"
        AF.request(url,method: .get,headers: headers).responseJSON { (response) in

            switch response.result {
            case .success:
                guard let json = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ImagesAPIResponse.self, from: json)
                    print(data)

                    self.gridImageViewCollectionViewManager.start(collectionView: self.collectionViewRef, storyManager: data)

                    

                }
                catch let error {
                    print(error)
                }
            case .failure(let error):
                print("Error : \(error.localizedDescription)")

            }

            DispatchQueue.main.async {

            }

        }


    }
}
