//
//  FilterViewController.swift
//  MatchMe
///
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SideMenu

class FilterViewController: UIViewController {
    
    let filterViewModel = FilterViewModel()
    let disposeBag = DisposeBag()

    //IBoutlet
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterViewModel.getRequest()
        bindComponent()
        
        navigationBarButtonUI()
        
    }
    
    fileprivate func navigationBarButtonUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(buttonCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(buttonApply))
    }
    
    @objc func buttonCancel() {
        dismissViewController()
    }
    
    //Applying the filter
    @objc func buttonApply() {
        filterViewModel.saveFilter()
        dismissViewController()
        guard let matchListViewController = navigationController?.viewControllers.first as? MatchListViewController else { return }
        matchListViewController.applyFilter.onNext(true)
    }
    
    func dismissViewController() {
        SideMenuManager.default.menuLeftNavigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
}

private extension FilterViewController {
    
    func bindComponent() {
        guard let tableView = tableView else { return }
        filterViewModel.filterCell.bind(to: tableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .sliderCell(let filterSlider):
                return self.makeFilterSliderCell(with: filterSlider, from: tableView, indexPath: indexPath)
            case .switchCell(let filterSwitch):
                return self.makeFilterSwitchCell(with: filterSwitch, from: tableView, indexPath: indexPath)
            }
            
            }.disposed(by: disposeBag)
    }
    
    func makeFilterSwitchCell(with element: FilterSwitch, from table: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell
        cell?.bindData(filter: element)
        return cell ?? UITableViewCell()
    }
    
    func makeFilterSliderCell(with element: FilterSlider, from table: UITableView,  indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: SliderCell.identifier, for: indexPath) as? SliderCell
        cell?.bindData(filter: element)
        return cell ?? UITableViewCell()
    }
}
