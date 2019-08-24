//
//  SliderCell.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/8/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import MultiSlider
import UIKit
import RxSwift
import RxCocoa

class SliderCell: UITableViewCell {

    let disposeBag = DisposeBag()

    var rangeValue:String {
        get {
            return multiSlider?.thumbCount ?? 1 > 1 ? "\(Int(multiSlider?.value.first ?? 0))" + "-" + "\(Int(multiSlider?.value.last ?? 0))" : "\(Int(multiSlider?.value.first ?? 0))"
        }
    }
    
    @IBOutlet var multiSlider: MultiSlider?
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelValue: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSlider()
    }
    
    func bindData(filter: FilterSlider) {
        labelTitle?.text = filter.title
        multiSlider?.thumbCount = filter.type == .single ? 1 : 2
        multiSlider?.minimumValue = CGFloat(filter.minRange)
        multiSlider?.maximumValue = CGFloat(filter.maxRange)
        multiSlider?.value = [CGFloat(filter.minValue), CGFloat(filter.maxValue)]
        labelValue?.text = rangeValue
        multiSlider?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                
                self?.labelValue?.text = self?.rangeValue
                filter.minValue = Int(self?.multiSlider?.value.first ?? 0)
                filter.maxValue = Int(self?.multiSlider?.value.last ?? 0)

            })
            .disposed(by:disposeBag)
        
    }
    
    func configureSlider() {
        multiSlider?.orientation = .horizontal
    }

}
