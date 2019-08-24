//
//  Utils.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit

func onMain(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}

func topController() -> UIViewController? {
    
    func follow(_ from:UIViewController?) -> UIViewController? {
        if let to = (from as? UITabBarController)?.selectedViewController {
            return follow(to)
        } else if let to = (from as? UINavigationController)?.visibleViewController {
            return follow(to)
        } else if let to = from?.presentedViewController {
            return follow(to)
        }
        return from
    }
    let root = UIApplication.shared.keyWindow?.rootViewController
    
    return follow(root)
    
}
