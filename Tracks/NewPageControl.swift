//
//  NewPageControl.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 13.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class NewPageControl: UIPageControl {

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        super.sendAction(action, to: target, for: event)
        updateDots()
    }

    private func updateDots() {
        let currentDot = subviews[currentPage]
        let largeScaling = CGAffineTransform(scaleX: 1.0, y: 1.0)
        let smallScaling = CGAffineTransform(scaleX: 0.75, y: 0.75)

        subviews.forEach {
            // Apply the large scale of newly selected dot.
            // Restore the small scale of previously selected dot.
            $0.transform = $0 == currentDot ? largeScaling : smallScaling
        }
    }
    public func setDotsWithBorder() {
        let currentDot = subviews[currentPage]
        subviews.forEach {
            $0.layer.borderWidth = $0 == currentDot ? 0 : 1.5
        }
    }

    override func updateConstraints() {
        super.updateConstraints()
        // We rewrite all the constraints
        rewriteConstraints()
    }

    private func rewriteConstraints() {
        let systemDotSize: CGFloat = 7.0
        let systemDotDistance: CGFloat = 16.0

        let halfCount = CGFloat(subviews.count) / 2
        subviews.enumerated().forEach {
            let dot = $0.element
            dot.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(dot.constraints)
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: systemDotSize),
                dot.heightAnchor.constraint(equalToConstant: systemDotSize),
                dot.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
                dot.centerXAnchor.constraint(equalTo: centerXAnchor, constant: systemDotDistance * (CGFloat($0.offset) - (halfCount - 0.5)))
            ])
        }
    }
}
