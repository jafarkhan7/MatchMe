//
//  UserImageCell.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/21/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
import SDWebImage

class UserImageCell: UITableViewCell {
    @IBOutlet weak var imageViewUser: UIImageView?
    @IBOutlet weak var labelNameAndAge: UILabel?
    
    func bindData(user:User) {
        imageViewUser?.sd_setImage(with: URL(string: user.image ?? ""), placeholderImage: UIImage(named: "profile"), options: SDWebImageOptions.retryFailed, context: nil)

        labelNameAndAge?.text = user.nameAndAge
    }

}
