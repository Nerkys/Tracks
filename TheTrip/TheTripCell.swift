//
//  TheTripCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 07.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheTripCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleAndDateLabel: UILabel!
    
    private var dataSource = [Statistics]()
    private var titleAndDateDataSource: Trip!
    private let itemsInSection: CGFloat = 3
    //private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let coverLayer = CALayer()
    

    
//    func configure(with model: [Statistics]) {
//        self.dataSource = model
//    }
    
    func configure(with model: Trip) {
        titleAndDateDataSource = model
        dataSource = model.statistics
        tripImage.image = UIImage(named: model.image)
        titleAndDateLabel.text = titleAndDateDataSource.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tripCollectionView.delegate = self
        tripCollectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        coverLayer.frame = tripImage.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.25
        tripImage.layer.addSublayer(coverLayer)
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(itemsInSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheTripCollectionViewCell", for: indexPath) as! TheTripCollectionViewCell
        let statistics = dataSource[indexPath.item + ((indexPath.section) * Int(itemsInSection))]
        cell.titleLabel.text = statistics.title
        cell.actionImage.image = UIImage(named: statistics.image)
        cell.valueLabel.text = String(statistics.value)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(ceil(tripCollectionView.contentOffset.x / tripCollectionView.frame.width))
        if pageControl?.currentPage == 0 {
            titleAndDateLabel.text = titleAndDateDataSource.title
        } else {
            titleAndDateLabel.text = titleAndDateDataSource.startedAt
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paggingSpace = sectionInsets.left * (itemsInSection + 1)
//        let availableWidth = tripCollectionView.frame.width - paggingSpace
        let widthPerItem = tripCollectionView.frame.width / itemsInSection
        return CGSize(width: widthPerItem, height: tripCollectionView.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        sectionInsets
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
    
}
