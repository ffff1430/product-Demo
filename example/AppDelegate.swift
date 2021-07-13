//
//  AppDelegate.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import UIKit
import DropDown
import SHOPSwift
import MaterialComponents

//Xcode12用＠main Xcode11以下是@UIAplicationMain
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow! = UIWindow()
    let router = AppCoordinator().strongRouter
    let realmMigration:RealmMigration = RealmMigration()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
            print("DEBUG build!")
        #elseif UAT
            print("UAT build!")
        #else
            print("Release build!")
        #endif
        SHOPSwiftAPI.basePath = "\(Environment.rootURL)"
        self.realmMigration.didApplicationLunch()
        router.setRoot(for: window)
        DropDown.startListeningToKeyboard()
        setNotificationCenter()
        SHOPSwiftAPI.requestBuilderFactory = MyRequestBuilderFactory()
        UINavigationBar.appearance().barTintColor = UIColor(named: "itembackGround")
        UINavigationBar.appearance().tintColor = .black
        return true
    }
    
    func setNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(appCameToForeground),
                                       name: UIApplication.willEnterForegroundNotification,
                                       object: nil)
    }
    
    @objc func appCameToForeground() {
        if TokenRealm().isAccessTokRnexpired() {
            router.trigger(.login)
        }
    }
    
}

