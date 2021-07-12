//
//  ProductCoordinator.swift
//  example
//
//  Created by B1591 on 2021/5/4.
//

import Foundation
import XCoordinator

enum ProductRoute: Route{
    case product
    case detailProduct
    case dismiss
}

class ProductCoordinator: NavigationCoordinator<ProductRoute> {
    init() {
        super.init(initialRoute: .product)
    }
    
    override func prepareTransition(for route: ProductRoute) -> NavigationTransition {
        switch route {
        case .product:
            let viewModel = ProductViewModel(router: unownedRouter, realm: TokenRealm())
            let viewController = ProductViewController(viewModel: viewModel)
            return .push(viewController, animation: .swirl)
        case .detailProduct:
            let viewModel = DetailProductViewModel()
            let viewController = DetailProductViewController(viewModel: viewModel)
            return .push(viewController, animation: .swirl)
        case .dismiss:
            return .dismiss()
        }
    }
}
