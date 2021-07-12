//
//  RoleCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import XCoordinator

enum RoleRoute: Route{
    case role
    case dismiss
}

class RoleCoordinator: NavigationCoordinator<RoleRoute> {
    init() {
        super.init(initialRoute: .role)
    }
    
    override func prepareTransition(for route: RoleRoute) -> NavigationTransition {
        switch route {
        case .role:
            let viewModel = RoleViewModel(router: unownedRouter)
            let viewController = RoleViewController(viewModel: viewModel)
            return .push(viewController, animation: .swirl)
        case .dismiss:
            return .dismiss()
        }
    }
}
