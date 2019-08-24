//
//  MatchListViewController.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import SideMenu

class MatchListViewController: UIViewController {
    var listViewModel = MatchListViewModel()
    let disposeBag = DisposeBag()
    let applyFilter: PublishSubject<Bool> = PublishSubject()
    
    @IBOutlet weak var buttonSideMenu: UIBarButtonItem?
    @IBOutlet var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel.requestData()
        bindComponent()
        initiateSideMenu()
        applyFilter.asObservable()
            .bind(onNext: { [weak self] _ in
                self?.listViewModel.applyFilter()
            })
            .disposed(by: disposeBag)
    }
    
    func initiateSideMenu() {
        
        SideMenuManager.default.menuLeftNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationViewController") as? UISideMenuNavigationController
        
    }
    
    func bindComponent() {
        guard let collectionView = collectionView  else { return }
        
        SVProgressHUD.show()
        //Showing the progress
        listViewModel.error.asObserver()
            .subscribe(onNext: { (error) in
                SVProgressHUD.dismiss()
                onMain {
                    Alert.showAlert(title: "Error", message: error.localizedDescription, .alert, cancelActionTitle: "", okActionTitle: "Ok")
                }
            })
            .disposed(by: disposeBag)
        
        //binding collectionView
        listViewModel.dataSouceObjects.asObservable()
            .do(onNext: { _ in
                SVProgressHUD.dismiss()
            })
            .bind(to: collectionView.rx.items(cellIdentifier: MatchListCell.identifier, cellType: MatchListCell.self)) {(row, element, cell) in
                if let object = element {
                    cell.bindData(object: object)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetailSegue" {
            guard let profileVC =  segue.destination as? UserDetailViewController, let cell = sender as? MatchListCell, let indexPath = collectionView?.indexPath(for: cell), let user = listViewModel.dataSouceObjects.value[indexPath.row] else { return }
            let profileViewModel = UserDetailViewModel(user: user)
            profileVC.profileViewModel = profileViewModel
            return
        }
    }
    
}
