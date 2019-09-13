//
//  JLSTAT.swift
//  SwiftSTAT
//
//  Created by Jemesl on 2019/9/14.
//  Copyright © 2019 Jemesl. All rights reserved.
//

import Foundation
import UIKit
struct AssociatedKeys {
    static var statBlockKey: String = "JLStatBlockKey"
}

extension JLSpace where Base: UIView {
    
    func setStatBlock<E>(defaultEnum: E, block: @escaping (Base, E) -> ()) {
        block(self.base, defaultEnum)
        objc_setAssociatedObject(self.base, &AssociatedKeys.statBlockKey, block, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func setStat<E>(e: E) {
        typealias STATBLOCK = (Base, E) -> ()
        if let statBlock = objc_getAssociatedObject(self.base, &AssociatedKeys.statBlockKey) as? STATBLOCK {
            statBlock(self.base, e)
        }
    }
}

extension UIView {
    func setStatBlock<Base, T>(base: Base, defaultEnum: T, block: @escaping (Base, T) -> ()){
        block(base, defaultEnum)
        objc_setAssociatedObject(self, &AssociatedKeys.statBlockKey, block, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func setStat<Base, T>(base: Base, e: T) {
        typealias STATBLOCK = (Base, T) -> ()
        if let statBlock = objc_getAssociatedObject(self, &AssociatedKeys.statBlockKey) as? STATBLOCK {
            statBlock(base, e)
        }
    }
}
