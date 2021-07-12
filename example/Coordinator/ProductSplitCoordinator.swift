//
//  ProductSplitCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import XCoordinator

enum ProductSplitRoute: Route {
    case product
}

class ProductSplitCoordinator: SplitCoordinator<ProductSplitRoute> {

    // MARK: Stored properties

    private let ProductRouter: StrongRouter<ProductRoute>

    // MARK: Initialization

    init(ProductRouter: StrongRouter<ProductRoute> = ProductCoordinator().strongRouter) {
        self.ProductRouter = ProductRouter

        super.init(master: ProductRouter, detail: nil)
    }

    // MARK: Overrides

    override func prepareTransition(for route: ProductSplitRoute) -> SplitTransition {
        switch route {
        case .product:
            return .showDetail(ProductRouter)
        }
    }

}
