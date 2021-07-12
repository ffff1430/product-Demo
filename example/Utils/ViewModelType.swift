//
//  ViewModelType.swift
//  example
//
//  Created by B1591 on 2021/4/27.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
