//
//  LoginViewModel.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa
import SHOPSwift
import RealmSwift
import Alamofire

class LoginViewModel: ViewModelType{
    
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let loginResult : Driver<AuthenticationResult>
    }
    
    private let router: UnownedRouter<AppRoute>
    
    private let realm: TokenRealm
    
    private let disposeBag = DisposeBag()
    
    init(router: UnownedRouter<AppRoute>, realm: TokenRealm) {
        self.router = router
        self.realm = realm
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        //拿到username和password
        let combine = Driver.combineLatest(input.password,
                                           input.username) {
            ($0, $1)
        }
        
        
        
        //得到loginAPI的response
        let loginResult = combine
            .asObservable()
            .flatMap { password, username in
                return AuthAPI.loginUsingPOST(body: CrowdCredentials(password: password, username: username))
            }
            .trackActivity(loading)
            .asDriver(onErrorRecover: { error in
                CustomProgressHUD().error()
                return Driver.just(AuthenticationResult.init())
            })
        
        return Output(loading: loading.asDriver(), loginResult: loginResult)
    }
    
    
    
    //取得AuthToken
    func getAuthToken(authenticationResult: AuthenticationResult) {
        guard let accessToken = authenticationResult.jwtTokenPair?.accessToken else { return }
        guard let refreshToken = authenticationResult.jwtTokenPair?.refreshToken else { return }
        self.realm.saveToken(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    //確認accessToken有沒有過期
    func isLogin() -> Bool {
        return self.realm.isAccessTokRnexpired()
    }
    
    //切換頁面到HomeSplitCoordinator這個路徑
    func usersButtonPressed() {
        router.trigger(.home(HomeSplitCoordinator().strongRouter))
    }
}


