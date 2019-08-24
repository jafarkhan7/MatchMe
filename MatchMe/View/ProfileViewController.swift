//
//  ProfileViewController.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/9/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class ProfileViewController: UITableViewController {

    var profileViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    //IBOutlet
    @IBOutlet weak var imageViewUser: UIImageView?
    @IBOutlet weak var labelName: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewModel.requestData()
        bindData()
        
    }
    
    private func bindData() {
        profileViewModel.user.asObservable()
            .subscribe(onNext: { [weak self] (user) in
                guard let user = CurrentUser.sharedInstance.user else { return }
                self?.labelName?.text = user.nameAndAge
                self?.imageViewUser?.sd_setImage(with: URL(string: user.image ?? ""), placeholderImage: nil, options: SDWebImageOptions.continueInBackground, context: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetailSegue" {
            let profileVC =  segue.destination as? UserDetailViewController
            guard let user = CurrentUser.sharedInstance.user else { return }
            let profileViewModel = UserDetailViewModel(user: user)
            profileVC?.profileViewModel = profileViewModel
            return
        }
    }
}



