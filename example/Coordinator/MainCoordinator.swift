//
//  MainCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import XCoordinator
import SideMenu

enum MainRoute: Route {
    case main
    case product(StrongRouter<ProductSplitRoute>?)
    case role(StrongRouter<RoleSplitRoute>?)
    case dismiss
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
    
    init() {
        super.init(initialRoute: .main)
    }
    
    override func prepareTransition(for route: MainRoute) -> NavigationTransition{
        switch route {
        case .main:
            let viewModel = MainViewModel(router: unownedRouter, realm: TokenRealm())
            let viewController = MainViewController(viewModel: viewModel)
            return .push(viewController)
        case let .product(router):
            return .presentFullScreen(router!)
        case let .role(router):
            return .presentFullScreen(router!)
        case .dismiss:
            return .multiple(.dismiss(), .dismissToRoot())
        }
    }
}
