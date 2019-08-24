//
//  Filter.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/8/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation

class FilterSlider {
    enum SliderType: String {
        case single = "single"
        case double = "double"
    }
     var title = ""
     var minRange = 0
     var maxRange = 0
     var minValue = 0
     var maxValue = 0
    var type = SliderType.double
    
    subscript(_ title:String) -> (minValue:Int,maxvalue:Int) {
        return (minValue,maxValue)
    }
    
    static func initWith(title: String, minRange: Int, maxRange: Int, type:String) -> FilterSlider {
        let filterSlider = FilterSlider()
        filterSlider.title = title
        filterSlider.minRange = minRange
        filterSlider.maxRange = maxRange
        filterSlider.maxValue = maxRange
        filterSlider.minValue = minRange
        filterSlider.type = SliderType.init(rawValue: type) ?? .double
        return filterSlider
    }
}

class FilterSwitch {
     var title = ""
     var isEnabled = false
    

    static func initWith(title: String, isEnabled: Bool) -> FilterSwitch {
        let filterSwitch = FilterSwitch()
        filterSwitch.title = title
        filterSwitch.isEnabled = isEnabled
        return filterSwitch
    }
}


