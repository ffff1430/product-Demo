//
//  BehaviorRelay+extension.swift
//  example
//
//  Created by B1591 on 2021/5/11.
//

import Foundation
import RxRelay

extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func append(_ subElement: Element.Element) {
        var newValue = value
        newValue.append(subElement)
        accept(newValue)
    }
    
    func append(contentsOf: [Element.Element]) {
        var newValue = value
        newValue.append(contentsOf: contentsOf)
        accept(newValue)
    }
    
    public func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
    
    public func removeAll() {
        var newValue = value
        newValue.removeAll()
        accept(newValue)
    }
    
}
