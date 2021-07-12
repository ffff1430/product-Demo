//
//  AppCoordinator.swift
//  example
//
//  Created by B1591 on 2021/4/26.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case login
    case home(StrongRouter<HomeRoute>?)
    case dismiss
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .login)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .login:
            let viewModel = LoginViewModel(router: unownedRouter, realm: TokenRealm())
            let viewController = LoginViewController(viewModel: viewModel)
            return .presentFullScreen(viewController)
        case let .home(router):
            return .presentFullScreen(router!)
        case .dismiss:
            return .dismiss()
        }
    }
    
}
