//
//  UserDetailViewTest.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/22/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import MatchMe

class UserDetailViewTest:QuickSpec {
    var profileViewModel:UserDetailViewModel!
    var profileVC:UserDetailViewController!
    let disposebag = DisposeBag()
    
    override func spec() {
        describe("show profile") {
            context("when user is passed") {
                beforeEach {
                    let user = User()
                    user.name = "sam"
                    user.age = 25
                    let city = City()
                    city.latitude = 53.000
                    city.longitude = -1.0191
                    user.height = 170
                    user.image = "http://thecatapi.com/api/images/get?format=src&type=gif"
                    user.city = city
                    user.profession = "engineer"
                    self.profileViewModel = UserDetailViewModel(user: user)
                    self.profileVC = UserDetailViewController.stubWith(with: self.profileViewModel)
                    UIApplication.shared.keyWindow?.rootViewController = self.profileVC
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    
                    // Test and Load the View at the Same Time!
                    _ = self.profileVC.view
                    
                    self.profileVC.viewDidLoad(); XCTAssertNotNil(self.profileVC.view)
                    
                }
                it("Success") {
                    expect(self.profileVC.tableView!.numberOfRows(inSection: 0) == 3).toEventually(beTrue(), timeout: 10.0, description: "Rows")
                }
            }
        }
    }
}
