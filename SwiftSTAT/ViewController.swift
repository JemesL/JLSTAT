//
//  ViewController.swift
//  SwiftSTAT
//
//  Created by Jemesl on 2019/9/14.
//  Copyright © 2019 Jemesl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        test1()
    }
    
    func test1() {
        let v = UIView()
        view.addSubview(v)
        v.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        v.jl.setStatBlock(defaultEnum: STATTF.falseCase) { (v, e) in
            switch e {
            case .trueCase:
                v.backgroundColor = .red
            case .falseCase:
                v.backgroundColor = .green
            }
        }
        
        v.jl.setStat(e: STATTF.falseCase)
        
        
        if let e: STATTF = v.jl.getStat() {
            print(e)
        }
    }


}

