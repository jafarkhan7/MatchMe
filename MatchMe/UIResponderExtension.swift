//
//  UIResponderExtension.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier: String {
        return String(describing: self)
    }
}
