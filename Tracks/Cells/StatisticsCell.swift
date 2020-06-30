//
//  StatisticsCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 24.06.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class StatisticsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

//    static func nib() -> UINib {
//        return UINib(nibName: "CollectionViewCell", bundle: nil)
//    }

    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //pageControl.hidesForSinglePage = true
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override func layoutSubviews() {
        view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor(red: 0.14, green: 0.18, blue: 0.37, alpha: 1).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.2
        view.clipsToBounds = false

        //layer.zPosition = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfPages = 2
        
        pageControl.numberOfPages = numberOfPages
        pageControl.isHidden = !(numberOfPages > 1)
        
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
//    func collectionView
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(ceil(scrollView.contentOffset.x / scrollView.frame.width))
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
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
