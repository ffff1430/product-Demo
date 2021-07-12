//
//  RoleSplitCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import XCoordinator

enum RoleSplitRoute: Route {
    case role
}

class RoleSplitCoordinator: SplitCoordinator<RoleSplitRoute> {

    // MARK: Stored properties

    private let RoleRouter: StrongRouter<RoleRoute>

    // MARK: Initialization

    init(RoleRouter: StrongRouter<RoleRoute> = RoleCoordinator().strongRouter) {
        self.RoleRouter = RoleRouter

        super.init(master: RoleRouter, detail: nil)
    }

    // MARK: Overrides

    override func prepareTransition(for route: RoleSplitRoute) -> SplitTransition {
        switch route {
        case .role:
            return .showDetail(RoleRouter)
        }
    }

}
