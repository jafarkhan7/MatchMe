//
//  UserDefaultExtension.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/10/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static var isFilterApplied:Bool {
        get {
          return UserDefaults.standard.bool(forKey: Keys.isFilterApplied)
        }
        set {
           UserDefaults.standard.set(newValue, forKey: Keys.isFilterApplied)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var age:(minValue:Int, maxValue: Int) {
        get {
       return (UserDefaults.standard.value(forKey: KeyRange.age.minimumValue) as? Int ?? 0, UserDefaults.standard.value(forKey: KeyRange.age.maxValue) as? Int ?? 0)
        }
        set {
            UserDefaults.standard.set(newValue.minValue, forKey: KeyRange.age.minimumValue)
            UserDefaults.standard.set(newValue.maxValue, forKey: KeyRange.age.maxValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var score:(minValue:Double, maxValue: Double) {
        get {
        return (UserDefaults.standard.value(forKey: KeyRange.score.minimumValue) as? Double ?? 0.0, UserDefaults.standard.value(forKey: KeyRange.score.maxValue) as? Double ?? 0.0)
        }
        set {
            UserDefaults.standard.set(newValue.minValue, forKey: KeyRange.score.minimumValue)
            UserDefaults.standard.set(newValue.maxValue, forKey: KeyRange.score.maxValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var height:(minValue:Int, maxValue: Int) {
        get { return (UserDefaults.standard.value(forKey: KeyRange.height.minimumValue) as? Int ?? 0, UserDefaults.standard.value(forKey: KeyRange.height.maxValue) as? Int ?? 0)
        }
        set {
            UserDefaults.standard.set(newValue.minValue, forKey: KeyRange.height.minimumValue)
            UserDefaults.standard.set(newValue.maxValue, forKey: KeyRange.height.maxValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var distance:(minValue:Int, maxValue: Int) {
        get { return (UserDefaults.standard.value(forKey: KeyRange.distance.minimumValue) as? Int ?? 0, UserDefaults.standard.value(forKey: KeyRange.distance.maxValue) as? Int ?? 0)
        }
        set {
            UserDefaults.standard.set(newValue.minValue, forKey: KeyRange.distance.minimumValue)
            UserDefaults.standard.set(newValue.maxValue, forKey: KeyRange.distance.maxValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isPhotoAvailable:Bool {
        get {
        return UserDefaults.standard.bool(forKey: KeyIsEnabled.photo.isEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KeyIsEnabled.photo.isEnabled)
            UserDefaults.standard.synchronize()

        }
    }
    
    static var isContactAvailable :Bool {
        get {
        return UserDefaults.standard.bool(forKey: KeyIsEnabled.contact.isEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KeyIsEnabled.contact.isEnabled)
            UserDefaults.standard.synchronize()

        }
    }
    
    static var isFavourite :Bool {
        get {
        return UserDefaults.standard.bool(forKey: KeyIsEnabled.favourite.isEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KeyIsEnabled.favourite.isEnabled)
            UserDefaults.standard.synchronize()

        }
    }
    
    enum KeyRange:String {
        case score
        case age
        case height
        case distance
        
        var maxValue: String {
           return self.rawValue + Keys.maxValue
        }
        
        var minimumValue: String {
            return self.rawValue + Keys.minValue
        }
    }
    
    enum KeyIsEnabled:String {
        case photo
        case contact
        case favourite
        
        var isEnabled: String {
            return self.rawValue + Keys.isEnabled
        }
    }
    
    struct Keys {
        static let maxValue = "maxValue"
        static let minValue = "minValue"
        static let isEnabled = "isEnabled"
        static let isFilterApplied = "isFilterApplied"
        
    }
}
