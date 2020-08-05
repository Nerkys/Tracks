//
//  Animator.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 05.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

final class Animator {
    
    private var hasAnimatedAllCells = false
    private let animation: Animation

    init(animation: @escaping Animation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)

        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
    
}

extension UITableView {
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}
