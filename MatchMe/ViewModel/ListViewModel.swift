//
//  ListViewModel.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MatchListViewModel {
    var apiManager: APIManagerProtocol = APIManager()
    var dataSouceObjects: BehaviorRelay<[User?]> = BehaviorRelay(value: [])
    let error : PublishSubject<APIManager.RequestError> = PublishSubject()
    fileprivate var allData:[User]?
    
    func requestData(){
        apiManager.requestData(path: "", method: .get, parameters: nil) {[weak self] (result) in
            switch result {
            case .success(let returnJson) :
                let json = JSONDecoder()
                do {
                    let serial = try JSONSerialization.jsonObject(with: returnJson, options: .mutableLeaves)
                    print(serial)
                    
                    var users = try json.decode(Matches.self, from: returnJson).user
                    CurrentUser.sharedInstance.user = users.first
                    let splitUser = Array(users[1 ..< users.count])
                    self?.allData = splitUser
                    self?.applyFilter()
                    
                }
                catch {
                    print(error)
                }
            case .failure(let error):
                self?.error.onNext(error)
                break
            }
        }
    }
    
    func applyFilter() {
        if UserDefaults.isFilterApplied {
            var filter:[User]? = allData?.filter { condition(user: $0)}

             if UserDefaults.isPhotoAvailable {
                filter = filter?.filter {($0.hasImage == UserDefaults.isPhotoAvailable)}
            }
             if UserDefaults.isContactAvailable {
                filter = filter?.filter {(UserDefaults.isContactAvailable == $0.hasContact)}
            }
             if UserDefaults.isFavourite {
                filter = filter?.filter {(UserDefaults.isFavourite == $0.favourited)}
            }
      
        guard let filteredUser = filter else {
            return dataSouceObjects.accept([])
        }
        dataSouceObjects.accept(filteredUser)
        }
        else {
            showDefaultData()
        }
    
    }
    
    func condition(user:User) -> Bool {
        
        func distance () -> Bool {
            guard let location = LocationManager.shared.location, let matchUserLocation = user.city?.location else {
                return CurrentUser.sharedInstance.user?.city?.name ?? "" == user.city?.name
            }
            let distance = Int(location.distance(from: matchUserLocation) / 1000)
            return (distance >= UserDefaults.distance.minValue) && (distance <= UserDefaults.distance.maxValue)
        }
        
        return (((user.age ?? 0 > UserDefaults.age.minValue) && (user.age ?? 0 < UserDefaults.age.maxValue))) && (((user.height ?? 0 > UserDefaults.height.minValue) && (user.height ?? 0 < UserDefaults.height.maxValue))) && (((user.matchScore > UserDefaults.score.minValue) && (user.matchScore < UserDefaults.score.maxValue))) && (((user.height ?? 0 > UserDefaults.height.minValue) && (user.height ?? 0 < UserDefaults.height.maxValue))) && distance()
    }
    
    func showDefaultData() {
        if let allUser = allData {
            dataSouceObjects.accept(allUser)
        }
    }
    
}
