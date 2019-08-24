//
//  CurrentUser.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation

class CurrentUser {
    static let sharedInstance = CurrentUser()
    var user:User?
}
