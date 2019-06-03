//
//  AlertController.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/2/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func createSimpleDismissibleAlert(with title: String,
                                             message: String,
                                             completion: ((UIAlertAction)-> Void)? = { _ in }) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alert.addAction(dismissAction)
        
        return alert
    }
}
