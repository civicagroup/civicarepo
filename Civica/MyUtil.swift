//
//  MyUtil.swift
//  Civica
//
//  Created by OSL on 4/20/22.
//

import Foundation
import UIKit

extension UIViewController {

    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
