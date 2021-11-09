//
//  GridViewCollectionViewManager.swift
//  GrideImageViewEx
//
//  Created by Pratik on 09/11/21.
//

import Foundation
import UIKit
import SDWebImage

class GridImageViewCollectionViewManager: NSObject {
    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    weak var presentDelegate: presentViewControllersDelegate?
    
    var storyData : ImagesAPIResponse = [] {
        didSet {
            collectionView?.reloadData()
            emptyView?.isHidden = storyData.count > 0
            let attributes = self.collectionView?.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
            let offsetPoint = CGPoint(x: 0, y: (attributes?.frame.origin.y ?? 0) - (collectionView?.contentInset.top ?? 0))
            self.collectionView?.setContentOffset(offsetPoint, animated: true)
        }
    }
    
    
    func start(collectionView: UICollectionView, storyManager: ImagesAPIResponse) {

        self.collectionView = collectionView
        self.storyData = storyManager

        let cellNib = UINib(nibName: "GrideImageCVC", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "GrideImageCVC")

        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
}

extension GridImageViewCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GrideImageCVC", for:indexPath) as! GrideImageCVC
        //managers.borderColor = UIColor.pinkColor
        if let image = storyData[indexPath.row].hdurl {
            cell.imgViewRef.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "no-image-available"))
        }
        
        return cell
    }
    
    

}

extension GridImageViewCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)  as? GrideImageCVC
        collectionView.bringSubviewToFront(selectedCell!)

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 1.2, y: 2)
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let unselectedCell = collectionView.cellForItem(at: indexPath)  as? GrideImageCVC
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
            unselectedCell?.transform = .identity
        })
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
