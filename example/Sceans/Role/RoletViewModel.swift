//
//  RoleViewModel.swift
//  example
//
//  Created by B1591 on 2021/4/28.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator
import SHOPSwift

class RoleViewModel: ViewModelType {
    
    struct Input {
        let ready: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let role: Driver<[RoleDto]>
    }
    
    let router: UnownedRouter<RoleRoute>
    
    init(router: UnownedRouter<RoleRoute>) {
        self.router = router
    }
    
    func usersButtonDismiss() {
        router.trigger(.dismiss)
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        let initRelo = input.ready
            .asObservable()
            .flatMap { _ in
                return RoleAPI.paginateRolesUsingGET(page: 0, size: 10).map { $0.content ?? [] }.trackActivity(loading)
            }
            .asDriver(onErrorRecover: { error in
                CustomProgressHUD().error()
                return Driver.just([])
            })
        
        return Output(loading: loading.asDriver(), role: initRelo)
    }
    
}
