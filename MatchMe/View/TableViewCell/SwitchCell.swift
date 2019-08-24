//
//  SwitchCell.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/8/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SwitchCell: UITableViewCell {
    @IBOutlet var switchControl: UISwitch!
    @IBOutlet var labelTitle: UILabel?
    private let disposeBag = DisposeBag()
    
    func bindData(filter: FilterSwitch) {
        labelTitle?.text = filter.title
        switchControl?.isOn = filter.isEnabled
        switchControl.rx.controlEvent(.valueChanged)
            .withLatestFrom(switchControl.rx.value)
            .subscribe(onNext : { bool in
                filter.isEnabled = bool
            })
            .disposed(by: disposeBag)
    }
}
