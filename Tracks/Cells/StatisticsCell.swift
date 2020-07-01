//
//  StatisticsCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 24.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    private let itemsInSection: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 2.5, bottom: 0.0, right: 0)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint.activate([
//            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
//            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
//            collectionView.topAnchor.constraint(equalTo: topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.clipsToBounds = false

        //layer.zPosition = 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(itemsInSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(ceil(scrollView.contentOffset.x / scrollView.frame.width))
    }
    
    
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        pageControl?.currentPage = Int(ceil(scrollView.contentOffset.x / scrollView.frame.width))
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
//        let cellWidth = (availableWidth / CGFloat(2)).rounded(.down)
        let paggingSpace = sectionInsets.left * (itemsInSection + 1)
        let availableWidth = collectionView.frame.width - paggingSpace
        let widthPerItem = availableWidth / itemsInSection
//        return CGSize(width: cellWidth, height: collectionView.frame.height)
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return CGSize(width: widthPerItem, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if DeviceType.IS_IPHONE_5 {
//            return  -16.0
//        }
        return sectionInsets.left
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        pageControl.currentPage = indexPath.item
//    }
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if pageControl.currentPage == indexPath.item {
//            pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.item
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let thisWidth = CGFloat(self.frame.width)
//    return CGSize(width: thisWidth, height: self.frame.height)
//    }

}
