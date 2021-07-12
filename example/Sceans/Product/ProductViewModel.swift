//
//  ProductViewModel.swift
//  example
//
//  Created by B1591 on 2021/5/4.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa
import SHOPSwift

class ProductViewModel: ViewModelType {
    
    struct Input {
        let ready: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        var product = BehaviorRelay(value: [ProductDto]())
    }
    
    var productData = BehaviorRelay(value: [ProductDto]())
    
    let router: UnownedRouter<ProductRoute>
    
    private var disposeBag = DisposeBag()
    
    let realm: TokenRealm
    
    var getEditInfo: ((ProductDto) -> ())?
    
    init(router: UnownedRouter<ProductRoute>, realm: TokenRealm) {
        self.router = router
        self.realm = realm
    }
    
    //回到前一頁
    func usersButtonDismiss() {
        router.trigger(.dismiss)
    }
    
    //切換到detail頁面
    func usersButtonPressedAtDetail() {
        router.trigger(.detailProduct)
    }
    
    //新增資料
    func postProduct(product: ProductCreation) {
        let loading = ActivityIndicator()
        _ = ProductAPI.createProductUsingPOST(body: product)
            .trackActivity(loading)
            .subscribe(onNext: { product in
                self.productData.append(ProductDto(attribute: product.attribute,
                                                   id: product.id,
                                                   listPrice: product.listPrice,
                                                   name: product.name,
                                                   ownerAccount: product.ownerAccount,
                                                   ownerAccountId: product.ownerAccountId,
                                                   status: product.status,
                                                   unitCost: product.unitCost))
            })
    }
    
    //更新欄位資料
    func putProduct(product: ProductUpdates, id: String, index: Int) {
        let loading = ActivityIndicator()

        _ = ProductAPI.updateProductUsingPUT(id: id, body: product)
            .trackActivity(loading)
            .subscribe(onNext: { product in
                self.getEditInfo?(ProductDto(attribute: product.attribute,
                                             id: product.id,
                                             listPrice: product.listPrice,
                                             name: product.name,
                                             ownerAccount: product.ownerAccount,
                                             ownerAccountId: product.ownerAccountId,
                                             status: product.status,
                                             unitCost: product.unitCost))
                var update = self.productData.value
                update[index].name = product.name
                update[index].attribute = product.attribute
                update[index].listPrice = product.listPrice
                update[index].unitCost = product.unitCost
                self.productData.accept(update)
            })
    }
    
    //取得資料
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        let initProduct = input.ready
            .asObservable()
            .flatMap { _ in
                return ProductAPI.paginateProductUsingGET(page: 0, size: 15).map { $0.content ?? [] }.trackActivity(loading)
            }
            .asDriver(onErrorRecover: { error in
                CustomProgressHUD().error()
                return Driver.just([])
            })
        
        initProduct
            .drive(onNext: { product in
                self.productData.accept(product)
            })
            .disposed(by: disposeBag)
        
        return Output(loading: loading.asDriver(), product: productData)
    }
    
}
