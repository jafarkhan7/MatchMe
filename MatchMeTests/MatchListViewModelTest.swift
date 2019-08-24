//
//  MatchMeTests.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Quick
import Nimble
@testable import MatchMe

class MatchListViewModelTest: QuickSpec {
    var listViewModel:MatchListViewModel!
    var matchListVC:MatchListViewController!
    
    override func spec() {
        describe("The 'List Of Mathces'") {
            
            context("when matchList view controller is initialized and server returns error") {
                beforeEach {
                    self.listViewModel = MatchListViewModel()
                    self.listViewModel.apiManager = APIManagerMock(expectedError: APIManager.RequestError.serverError)

                    self.matchListVC = MatchListViewController.stubWith(with: self.listViewModel)
                }

                it("should return error") {
                    expect(self.matchListVC.collectionView?.numberOfItems(inSection: 0) == 0).toEventually(beTrue(), timeout: 6.0, description: "Success")
                }
            }
            
            context("when matchList view controller is initialized and server returns error") {
                beforeEach {
                    UserDefaults.isFilterApplied = false
                    self.initiateMatchList()
                }
                
                it("should return error") {
                    expect(self.matchListVC.collectionView?.numberOfItems(inSection: 0) == 4).to(beTrue())
                }
            }
            
            context("When applying filter") {
                
                beforeEach {
                    UserDefaults.isPhotoAvailable = true
                    UserDefaults.isContactAvailable = true
                    UserDefaults.isFavourite = true
                    UserDefaults.distance = (0,300)
                    UserDefaults.height = (150,175)
                    UserDefaults.score = (0,80)
                    UserDefaults.age = (20,50)
                    UserDefaults.isFilterApplied = true
                    self.initiateMatchList()
                }
                
                it("after applying filter", closure: {
                    expect(self.matchListVC.collectionView?.numberOfItems(inSection: 0) == 1).to(beTrue())
                })
            }
            
            context("Selecting a user") {
             
                beforeEach {
                    UserDefaults.isFilterApplied = false
                    self.initiateMatchList()
                    let navigationController = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController)
                    navigationController.viewControllers = [self.matchListVC]
                    self.matchListVC.beginAppearanceTransition(true, animated: true)
                    
                    
                }
                
                it("Selecting the cell") {
                    waitUntil(timeout: 2.0, action: { done in
                        let cell = self.matchListVC.collectionView!.cellForItem(at: IndexPath(item: 0, section: 0)) as? MatchListCell
                        self.matchListVC.performSegue(withIdentifier: "UserDetailSegue", sender: cell)
                        expect(self.matchListVC.navigationController?.topViewController!.isKind(of: UserDetailViewController.self)).to(beTrue(), description: "Success")
                        done()
                    })
//
                }
            }
        }
    }
    
    func initiateMatchList() {
        self.listViewModel = MatchListViewModel()
        let path = Bundle(for: type(of: self)).path(forResource:"document",ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        self.listViewModel.apiManager = APIManagerMock(expectedJSON: data)
        self.matchListVC = MatchListViewController.stubWith(with: self.listViewModel)

        
    }
}

