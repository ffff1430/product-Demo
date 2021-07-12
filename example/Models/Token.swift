//
//  token.swift
//  example
//
//  Created by B1591 on 2021/5/13.
//

import Foundation
import Realm
import RealmSwift

class Token: Object {
    @objc dynamic var accessToken = ""
    @objc dynamic var refreshToken = ""
}
