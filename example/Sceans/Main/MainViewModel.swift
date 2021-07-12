//
//  MainViewModel.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

class MainViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let loading: Driver<Bool>
        let repos: Driver<[Item]>
    }
    
    var itemContent = Driver.just([Item(name: "產品列表", image: "products"),
                                   Item(name: "富邦活動", image: "celebrate"),
                                   Item(name: "行動辦公", image: "office"),
                                   Item(name: "員工福利", image: "gift"),
                                   Item(name: "關懷信箱", image: "gmail"),
                                   Item(name: "員工設定", image: "settings")])
    
    let router: UnownedRouter<MainRoute>
    
    let realm: TokenRealm
    
    init(router: UnownedRouter<MainRoute>, realm: TokenRealm) {
        self.router = router
        self.realm = realm
    }
    
    func transform() -> Output {
        let loading = ActivityIndicator()
        
        return Output(loading: loading.asDriver(), repos: itemContent)
    }
    
    func usersButtonPressedAtRole() {
        router.trigger(.role(RoleSplitCoordinator().strongRouter))
    }
    
    func usersButtonPressedAtProduct() {
        router.trigger(.product(ProductSplitCoordinator().strongRouter))
    }
    
    func logout() {
        realm.emptyAccessTokenAndRefreshToken()
        router.trigger(.dismiss)
    }
}
