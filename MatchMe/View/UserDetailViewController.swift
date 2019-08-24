//
//  UserDetailViewController.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/14/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var profileViewModel:UserDetailViewModel?
    
    //IBOutlet
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindComponent()
    }
    
    func bindComponent() {
        guard let tableView = tableView else { return }
        tableView.delegate = nil
        tableView.dataSource = nil
        profileViewModel?.userCell.asObservable()
        .bind(to: tableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .userImageCell(let user):
                return self.makeUserImageCell(with: user, from: tableView, indexPath: indexPath)
            case .userOtherDetailCell(let user):
               return self.makeUserOtherDetailCell(with: (title: user.title, value: user.value), from: tableView, indexPath: indexPath)
            }
            
            }.disposed(by: disposeBag)
    }
    
    func makeUserImageCell(with element: User, from table: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: UserImageCell.identifier, for: indexPath) as? UserImageCell
        cell?.bindData(user: element)
        return cell ?? UITableViewCell()
    }
    
    func makeUserOtherDetailCell(with element: (title:String,value:String), from table: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: UserDescriptionCell.identifier, for: indexPath) as? UserDescriptionCell
        cell?.bindData(element: element)
        return cell ?? UITableViewCell()
    }
}
