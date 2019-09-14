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
    static var statKey: String = "JLStatKey"
}

extension JLSpace where Base: UIView {
    
    func setStatBlock<E>(defaultEnum: E, block: @escaping (Base, E) -> ()) {
        typealias STATBE = STAT<Base, E>
        let stat = STATBE(e: defaultEnum, block: block)
        objc_setAssociatedObject(self.base, &AssociatedKeys.statKey, stat, .OBJC_ASSOCIATION_RETAIN)
        
        block(self.base, defaultEnum)
    }
    
    func setStat<E>(e: E) {
        typealias STATBE = STAT<Base, E>
        if var stat = objc_getAssociatedObject(self.base, &AssociatedKeys.statKey) as? STATBE {
            stat.block?(self.base, e)
            stat.e = e
            objc_setAssociatedObject(self.base, &AssociatedKeys.statKey, stat, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func getStat<E>() -> E? {
        if let statBlock = objc_getAssociatedObject(self.base, &AssociatedKeys.statKey) as? STAT<Base, E> {
            return statBlock.e
        }
        return nil
    }
}

struct STAT<Base, E> {
    typealias STATBLOCK = (Base, E) -> ()
    
    var block: STATBLOCK?
    var e: E?
    init(e: E, block: @escaping STATBLOCK) {
        self.block = block
        self.e = e
        print("STAT init")
    }
}


enum STATTF: Int {
    case trueCase = 1
    case falseCase = 0
}

extension STATTF {
    
    static func withBool(_ b: Bool) -> STATTF {
        return b ? .trueCase : .falseCase
    }

    func toBool() -> Bool {
        return self == .trueCase ? true : false
    }
}
