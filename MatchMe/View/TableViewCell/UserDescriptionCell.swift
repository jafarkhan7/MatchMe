//
//  UserDescriptionCell.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/21/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit

class UserDescriptionCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
    
    func bindData(element:(title:String,value:String)) {
        labelTitle?.text = element.title
        labelDescription?.text = element.value
    }
    
}
