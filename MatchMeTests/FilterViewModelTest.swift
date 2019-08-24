//
//  FilterViewModelTest.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/23/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import MatchMe

class FilterViewModelTest: QuickSpec {
    var filterViewModel:FilterViewModel!
    var filterVC:FilterViewController!
    
    override func spec() {
        describe("The 'Filter data'") {
            
            context("when showing the filter component data") {
                
                beforeEach {
                    self.initiateFilterVC()
                    
                }
                
                it("should return filter value on component") {
                    let cellHasPhoto = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 0, section: 0)) as! SwitchCell
                    let cellHasContact = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 1, section: 0)) as! SwitchCell
                    let cellHasFavourite = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 2, section: 0)) as! SwitchCell
                    let cellScore = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 3, section: 0)) as! SliderCell
                    let cellAge = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 4, section: 0)) as! SliderCell
                    let cellHeight = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 5, section: 0)) as! SliderCell
                    let cellDistance = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 6, section: 0)) as! SliderCell


                    expect(cellHasPhoto.switchControl!.isOn == UserDefaults.isPhotoAvailable).to(beTrue())
                    expect(cellHasContact.switchControl!.isOn == UserDefaults.isContactAvailable).to(beTrue())
                    expect(cellHasFavourite.switchControl!.isOn == UserDefaults.isFavourite).to(beTrue())
                    let rangeScoreValue = "2-88"
                    expect(cellScore.labelTitle?.text == FilterViewModel.FilterComponentSlider.score.rawValue).to(beTrue())
                    expect(cellScore.labelValue?.text == rangeScoreValue).to(beTrue())
                    
                    let rangeAgeValue = "20-30"
                    expect(cellAge.labelTitle?.text == FilterViewModel.FilterComponentSlider.age.rawValue).to(beTrue())
                    expect(cellAge.labelValue?.text == rangeAgeValue).to(beTrue())

                    let rangeHeightValue = "150-175"
                    expect(cellHeight.labelTitle?.text == FilterViewModel.FilterComponentSlider.height.rawValue).to(beTrue())
                    expect(cellHeight.labelValue?.text == rangeHeightValue).to(beTrue())
                    
                    let rangeDistanceValue = "10-200"
                    expect(cellDistance.labelTitle?.text == FilterViewModel.FilterComponentSlider.distance.rawValue).to(beTrue())
                    expect(cellDistance.labelValue?.text == rangeDistanceValue).to(beTrue())


                }
            }
            
            context("when appliyng the filter component data") {
                
                beforeEach {
                    self.initiateFilterVC()
                    let cellHasContact = self.filterVC.tableView!.cellForRow(at: IndexPath(row: 1, section: 0)) as! SwitchCell
                    cellHasContact.switchControl.setOn(true, animated: true)
                    cellHasContact.switchControl?.sendActions(for: .valueChanged)
                    self.filterVC.buttonApply()
                    
                }
                it("Applying filter") {
                    expect(UserDefaults.isContactAvailable == true).to(beTrue())
                }
            }
            
        }
    }
    
    func initiateFilterVC() {
        self.filterViewModel = FilterViewModel()
        UserDefaults.isPhotoAvailable = true
        UserDefaults.isContactAvailable = false
        UserDefaults.isFavourite = true
        UserDefaults.distance = (10,200)
        UserDefaults.height = (150,175)
        UserDefaults.score = (2,88)
        UserDefaults.age = (20,30)
        self.filterVC = FilterViewController.getViewController()
        self.filterVC.beginAppearanceTransition(true, animated: true)
    }
}
