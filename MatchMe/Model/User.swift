//
//  User.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import MapKit

 class User: Codable {
    var name:String?
    var age:Int?
    var profession:String?
    var height:Int?
    var image:String?
    var compatiblityScore:Double?
    var numberOfContacts:Int?
    var favourite:Bool?
    var religion:String?
    var city:City?
    
    var nameAndAge: String {
        let ageDecription = age ?? 0 > 0 ? ", \(age ?? 0)" : ""
       return (name ?? "") + ageDecription
    }
    
    var matchScore: Double {
       return (compatiblityScore ?? 0.0) * 100.0
    }
    
    var hasImage:Bool {
        return (image?.count ?? 0) > 0 ? true : false
    }
    
    var hasContact:Bool {
        return numberOfContacts ?? 0 > 0 ? true : false
    }
    
    var favourited:Bool {
        return favourite ?? false
    }
    
    var cityName:String {
        return city?.name ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case profession = "job_title"
        case height = "height_in_cm"
        case image = "main_photo"
        case compatiblityScore = "compatibility_score"
        case numberOfContacts = "contacts_exchanged"
        case religion
        case age
        case favourite
        case city
    }
}

 class City: Codable {
    var name:String?
    var latitude:Double?
    var longitude:Double?
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case name
    }
}

extension City {
    var location: CLLocation {
        return CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0) 
    }
}

class Matches: Codable {
    let user:[User]
    private enum CodingKeys: String, CodingKey {
        case user = "matches"
    }
}
