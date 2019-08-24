//
//  ProfileViewModel.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/24/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    var user: BehaviorRelay<User?> = BehaviorRelay(value: User())

    func requestData() {
        guard let currentUser = CurrentUser.sharedInstance.user else { return }
        self.user.accept(currentUser)
    }
    
    
}
