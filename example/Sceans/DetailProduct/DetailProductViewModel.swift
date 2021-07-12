//
//  DetailProductViewModel.swift
//  example
//
//  Created by B1591 on 2021/5/5.
//

import Foundation
import RxSwift
import RxCocoa
import SHOPSwift

class DetailProductViewModel: ViewModelType {
    
    struct Input {
        let ready: Driver<Void>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let productSpec: Driver<[ProductSpecDto]>
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        let initProductSpec = input.ready
            .asObservable()
            .flatMap { _ in
                return ProductSpecAPI.paginateProductSpecUsingGET(page: 0, size: 10).map { $0.content ?? [] }.trackActivity(loading)
            }
            .asDriver(onErrorRecover: { error in
                CustomProgressHUD().error()
                return Driver.just([])
            })
            
        return Output(loading: loading.asDriver(), productSpec: initProductSpec)
    }
    
}
