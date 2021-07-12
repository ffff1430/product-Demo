//
//  HomeSplitCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import XCoordinator

enum HomeRoute: Route {
    case main
}

class HomeSplitCoordinator: SplitCoordinator<HomeRoute> {

    // MARK: Stored properties

    private let MainRouter: StrongRouter<MainRoute>

    // MARK: Initialization

    init(MainRouter: StrongRouter<MainRoute> = MainCoordinator().strongRouter) {
        self.MainRouter = MainRouter

        super.init(master: MainRouter, detail: nil)
    }

    // MARK: Overrides

    override func prepareTransition(for route: HomeRoute) -> SplitTransition {
        switch route {
        case .main:
            return .showDetail(MainRouter)
        }
    }

}
