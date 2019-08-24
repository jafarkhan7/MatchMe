//
//  UserDetailViewModel.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/14/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserDetailViewModel {
    
    enum ProfileCellType  {
        case userImageCell(user:User)
        case userOtherDetailCell(user:(title:String,value:String))
    }
    
    var userCell: Observable<[ProfileCellType]> {
        return cells.asObservable()
    }
    
    private let cells = BehaviorRelay<[ProfileCellType]>(value: [])
    private var combinedCell:[ProfileCellType] = [ProfileCellType]()
    private let user:User
    
    init(user:User) {
        self.user = user
        setUserDetail(user: user)
    }
    
    enum Content:String,CaseIterable {
        case age = "Age"
        case location = "Location"
        case profession = "Profession"
        case height = "Height"
        case religion = "Religion"
    }
  
    func setUserDetail(user:User) {
        let userImageCell = ProfileCellType.userImageCell(user: user)
        combinedCell.append(userImageCell)
        
        var userDetail:[String:String] = [Content.location.rawValue:user.cityName,Content.profession.rawValue:user.profession ?? "", Content.religion.rawValue:user.religion ?? ""]
        if user.height ?? 0 > 0 {
            userDetail[Content.height.rawValue] = String(describing: user.height ?? 0)
        }
        let filtered = userDetail.filter { $0.value.count > 0 }
        
        filtered.sorted { $0.key < $1.key }.forEach { (key,value) in
            let userOtherDetailCell = ProfileCellType.userOtherDetailCell(user: (title: key, value: value))
            combinedCell.append(userOtherDetailCell)
        }
        cells.accept(combinedCell)
        
    }
}
