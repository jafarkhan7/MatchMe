//
//  ViewController + stub.swift
//  MatchMeTests
//
//  Created by Abdus Mac on 8/22/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
@testable import MatchMe

protocol Navigatable { }
extension UIViewController: Navigatable {}
extension Navigatable where Self: UIViewController {
    static func getViewController() -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier) as? Self
        return viewController ?? Self()
    }
}

extension MatchListViewController {
    static func stubWith(with viewModal:MatchListViewModel) -> MatchListViewController {
    
        let matchListVC = self.getViewController()
        matchListVC.listViewModel = viewModal
        _ = matchListVC.view
        return matchListVC
    }
}

extension UserDetailViewController {
    static func stubWith(with viewModal:UserDetailViewModel) -> UserDetailViewController {
        
        let profileVC = UserDetailViewController.getViewController()
        profileVC.profileViewModel = viewModal
        return profileVC
    }
}

