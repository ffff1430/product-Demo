//
//  dismissKeyboard.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
