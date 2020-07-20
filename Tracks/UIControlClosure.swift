//
//  UIControlClosure.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 20.07.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class UIControlClosure {
    private let closure: () -> Void
    init(attachTo: AnyObject, closure: @escaping () -> Void) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    @objc func invoke() {
        closure()
    }
}
extension UIControl {
    func addAction(for controlEvents: UIControl.Event, action: @escaping () -> Void) {
        let sleeve = UIControlClosure(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(UIControlClosure.invoke), for: controlEvents)
    }
    func removeAllActions() {
        removeTarget(self, action: #selector(UIControlClosure.invoke), for: allControlEvents)
        objc_removeAssociatedObjects(self)
    }
}
