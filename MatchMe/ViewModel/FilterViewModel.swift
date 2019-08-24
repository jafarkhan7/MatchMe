//
//  FilterViewModel.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/8/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FilterViewModel {
    
    enum FilterComponentSlider: String {
        case score = "Combatibility Score"
        case age = "Age"
        case height = "Height"
        case distance = "Distance in KM"
        
        var value: String {
            switch self {
            case .score : return "score"
            case .age : return "age"
            case .height : return "height"
            case .distance : return "distance"
                
            }
        }
    }
    
    enum FilterComponentSwitch: String {
        case photo = "Has Photo"
        case contact = "Has Contact"
        case favourite = "Favourite"
        
        var value: String {
            switch self {
            case .photo : return "photo"
            case .contact : return "contact"
            case .favourite: return "favourite"
            }
        }
    }
    
    enum FilterCellType {
        case switchCell(cellViewModel: FilterSwitch)
        case sliderCell(cellViewModel: FilterSlider)
    }
    
    private let cells = BehaviorRelay<[FilterCellType]>(value: [])
    private var combinedCellType:[FilterCellType] = [FilterCellType]()
    private var filterSwitch = [FilterSwitch]()
    private var filterSlider = [FilterSlider]()
    
    var filterCell: Observable<[FilterCellType]> {
        return cells.asObservable()
    }
    
    func getRequest() {
        combinedCellType.append(contentsOf: getFilterCellTypeSwitch())
        combinedCellType.append(contentsOf: getFilterCellTypeSlider())
        cells.accept(combinedCellType)
    }
    
    func saveFilter() {
        
        UserDefaults.isFilterApplied = true
        
        filterSlider.forEach { (filterSlider) in
            if let filterTitle = FilterComponentSlider.init(rawValue: filterSlider.title) {

               
                let keyMaxValue = filterTitle.value + UserDefaults.Keys.maxValue
                let keyMinValue = filterTitle.value + UserDefaults.Keys.minValue
                UserDefaults.standard.setValue(filterSlider.maxValue,forKey: keyMaxValue)
                UserDefaults.standard.setValue(filterSlider.minValue, forKey: keyMinValue)
                UserDefaults.standard.synchronize()
            }
        }
        
        filterSwitch.forEach { (filterSwitch) in
            if let filterTitle = FilterComponentSwitch.init(rawValue: filterSwitch.title) {
                UserDefaults.standard.set(filterSwitch.isEnabled, forKey: filterTitle.value + UserDefaults.Keys.isEnabled)
                UserDefaults.standard.synchronize()
            }
        }
    }
}

fileprivate extension FilterViewModel {
    
    func getFilterCellTypeSwitch() -> [FilterViewModel.FilterCellType] {
        let filterSwitch = [["title" : "Has Photo",
                             "value" : false],
                            ["title" : "Has Contact",
                             "value" : false],
                            ["title" : "Favourite",
                             "value" : false]]
        
        let arrayFilterTypeSwitch = filterSwitch.compactMap { [weak self] (obj) -> FilterCellType in
            let title = obj["title"] as? String ?? ""
            let value = obj["value"] as? Bool ?? false
            let element = FilterSwitch.initWith(title: title, isEnabled: value)
            if let filterTitle = FilterComponentSwitch.init(rawValue: title) {
                let keyEnabled = UserDefaults.KeyIsEnabled.init(rawValue: filterTitle.value)?.isEnabled ?? ""
                element.isEnabled = UserDefaults.standard.bool(forKey: keyEnabled)
            }
            self?.filterSwitch.append(element)
            return FilterCellType.switchCell(cellViewModel: element)
        }
        return arrayFilterTypeSwitch
    }
    
    func getFilterCellTypeSlider() -> [FilterViewModel.FilterCellType] {
        let filterSlider = [["title" : "Combatibility Score",
                             "type":"double",
                             "minValue" : 1,"maxValue": 99, "minRange": 1, "maxRange": 99],
                            ["title" : "Age",
                             "type":"double",
                             "minValue" : 18,"maxValue": 95],
                            ["title" : "Height",
                             "type":"double",
                             "minValue" : 135,"maxValue":210],
                            ["title" : "Distance in KM",
                             "type":"single",
                             "minValue" : 0,"maxValue": 300]]
        let arrayFilterTypeSlider = filterSlider.compactMap { [weak self] (obj) -> FilterCellType in
            let title = obj["title"] as? String ?? ""
            let minRange = obj["minValue"] as? Int ?? 0
            let maxRange = obj["maxValue"] as? Int ?? 0
            let type = obj["type"] as? String ?? ""

            let element = FilterSlider.initWith(title: title, minRange: minRange, maxRange: maxRange, type: type)
            
            if let filterTitle = FilterComponentSlider.init(rawValue: title) {
                let keyMinValue = UserDefaults.KeyRange.init(rawValue: filterTitle.value)?.minimumValue ?? ""
                element.minValue = UserDefaults.standard.value(forKey: keyMinValue) as? Int ?? element.minRange
                let keyMaxValue = UserDefaults.KeyRange.init(rawValue: filterTitle.value)?.maxValue ?? ""
                element.maxValue = UserDefaults.standard.value(forKey: keyMaxValue) as? Int ?? element.maxRange
                
            }
            self?.filterSlider.append(element)
            return FilterCellType.sliderCell(cellViewModel: element)
        }
        return arrayFilterTypeSlider
    }
}
