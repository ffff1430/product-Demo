//
//  tokenRealm.swift
//  example
//
//  Created by B1591 on 2021/5/13.
//

import Foundation
import Realm
import RealmSwift
import JWTDecode
import SHOPSwift

class TokenRealm {
    
    func saveToken(accessToken: String, refreshToken: String) {
        let realm = try! Realm()
        let token = Token()
        token.accessToken = accessToken
        token.refreshToken = refreshToken
        try! realm.write {
            realm.deleteAll()
            realm.add(token)
        }
    }
    
    func emptyAccessTokenAndRefreshToken() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func getAccessToken() -> String {
        let realm = try! Realm()
        let result = realm.objects(Token.self)
        guard let accessToken = result.first?.accessToken else { return "" }
        if accessToken == "" {
            return ""
        }
        return accessToken
    }
    
    func getRefreshToken() -> String {
        let realm = try! Realm()
        let result = realm.objects(Token.self)
        guard let refreshToken = result.first?.refreshToken else { return "" }
        if refreshToken == "" {
            return ""
        }
        return refreshToken
    }
    
    func isAccessTokRnexpired() -> Bool {
        let realm = try! Realm()
        let result = realm.objects(Token.self)
        guard let accessToken = result.first?.accessToken else { return true }
        if accessToken == "" {
            return true
        }
        let jwt = try! decode(jwt: accessToken)
        return jwt.expired
    }
    
    func setAccessTokenAtCustomHeader(accessToken: String) {
        let bearerToken = "Bearer \(accessToken)"
        SHOPSwiftAPI.customHeaders = ["Authorization": bearerToken]
    }

}

class RealmMigration {
    
    
    func didApplicationLunch () {
        self.migrationVersion()
    }
    
    func migrationVersion() {
        
        
        let config = Realm.Configuration(
            
            schemaVersion : 2 ,
            
            migrationBlock : { migration , oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    
//                    ???????????????????????????????????????????????????????????????????????????????????????
//                    ??????????????????????????????????????????
                }
                
            }
            
        )
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
}
