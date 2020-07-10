//
//  TheDayStatisticsCell.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 10.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TheDayStatisticsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    @IBOutlet var view: UIView!
    @IBOutlet var theDayCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var dateLabel: UILabel!
    
    private var dataSource = [Statistics]()
    private var dateDataSource: Day!
    
    private let itemsInSection: CGFloat = 3
    
    func configure(with model: Day) {
        dataSource = model.statistics
        dateLabel.text = dateDataSource.date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theDayCollectionView.delegate = self
        theDayCollectionView.dataSource = self
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(itemsInSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheDayCollectionViewCell", for: indexPath) as! TheDayCollectionViewCell
        let statistics = dataSource[indexPath.item + ((indexPath.section) * Int(itemsInSection))]
        cell.titleLabel?.text = statistics.title
        cell.actionImage?.image = UIImage(named: statistics.image)
        cell.valueLabel?.text = String(statistics.value)
        return cell
        
    }
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl?.currentPage = Int(ceil(theDayCollectionView.contentOffset.x / theDayCollectionView.frame.width))
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let paggingSpace = sectionInsets.left * (itemsInSection + 1)
    //        let availableWidth = tripCollectionView.frame.width - paggingSpace
            let widthPerItem = theDayCollectionView.frame.width / itemsInSection
            return CGSize(width: widthPerItem, height: theDayCollectionView.frame.height)
        }
    
}
