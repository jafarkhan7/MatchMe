//
//  MatchListCell.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
import SDWebImage

class MatchListCell: UICollectionViewCell {
    
    // MARK: IBoutlets
    @IBOutlet var imageViewUser: UIImageView?
    
    // MARK: Binding
    func bindData(object: User) {
        
        imageViewUser?.sd_setImage(with: URL(string: object.image ?? ""), placeholderImage: UIImage(named: "profile"), options: SDWebImageOptions.retryFailed, context: nil)
    }
}
