//
//  ProfileViewModelTest.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/24/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import MatchMe

class ProfileViewModelTest: QuickSpec {
    var profileViewController:ProfileViewController!
    var profileViewModel:ProfileViewModel!
    
    override func spec() {
        describe("ProfileView") {
            
            context("Showing current user") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource:"document",ofType: "json")
                    let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
                    let json = JSONDecoder()
                    
                        let users = try! json.decode(Matches.self, from: data).user
                     CurrentUser.sharedInstance.user = users.first
                    self.profileViewController = ProfileViewController.getViewController()
                    _ = self.profileViewController.view
                }
                it("Show the user details") {
                    expect(self.profileViewController.labelName?.text == "Caroline, 41").to(beTrue())
                }
            }
        }
    }
}
