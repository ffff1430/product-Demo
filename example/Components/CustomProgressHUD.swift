//
//  MBProgressHUD.swift
//  example
//
//  Created by B1591 on 2021/6/26.
//

import Foundation
import UIKit
import SVProgressHUD

class CustomProgressHUD {
    
    func loading(loading: Bool) {
        DispatchQueue.main.async {
            if loading == true {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: "Success")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    func error() {
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: "Error")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
}
