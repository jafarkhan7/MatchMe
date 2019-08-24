//
//  Alert.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/7/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit

 class Alert: NSObject {
    
    class func showAlert(title:String = "",message:String = "",_ style:UIAlertController.Style = .alert,cancelActionTitle:String = "",okActionTitle:String = "",_ dismissAlert:Bool = false,handlerCancelAction: ((UIAlertAction) -> Void)? = nil,handlerOkAction: ((UIAlertAction) -> Void)? = nil)  {
        let alert :UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if cancelActionTitle.count > 0 {
            
            let cancelAction = UIAlertAction(title: cancelActionTitle, style: UIAlertAction.Style.default) { (action) in
                
                
                handlerCancelAction?(action)
            }
            alert.addAction(cancelAction)
        }
        
        if okActionTitle.count > 0  {
            let okAction = UIAlertAction(title: okActionTitle, style: .default) { (action) in
                handlerOkAction?(action)
            }
            alert.addAction(okAction)
        }
        if dismissAlert {
            onMain(after: 1) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
        onMain {
            topController()?.present(alert, animated: true, completion: nil)

        }
        
    }
    
    
}
