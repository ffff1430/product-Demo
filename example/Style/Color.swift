//
//  Color.swift
//  example
//
//  Created by B1591 on 2021/6/14.
//

import UIKit
import MaterialComponents

open class Color {
    
    open class func textFieldColor() -> MDCContainerScheming {
        let colorScheme = MDCContainerScheme()
        guard let color = UIColor(named: "primaryColor") else { return colorScheme}
        colorScheme.colorScheme.primaryColor = color
        colorScheme.colorScheme.primaryColorVariant = color
        colorScheme.colorScheme.onPrimaryColor = color
        colorScheme.colorScheme.secondaryColor = color
        colorScheme.colorScheme.onSecondaryColor = color
        colorScheme.colorScheme.surfaceColor = color
        colorScheme.colorScheme.onSurfaceColor = color
        colorScheme.colorScheme.backgroundColor = color
        colorScheme.colorScheme.onBackgroundColor = color
        return colorScheme
    }
    
    open class func buttonColor() -> MDCContainerScheming {
        let scheme = MDCContainerScheme()
        guard let color = UIColor(named: "primaryColor") else { return scheme}
        scheme.colorScheme.primaryColor = color
        scheme.colorScheme.primaryColorVariant = color
        scheme.colorScheme.onPrimaryColor = .white
        scheme.colorScheme.secondaryColor = color
        scheme.colorScheme.onSecondaryColor = .white
        scheme.colorScheme.surfaceColor = color
        scheme.colorScheme.onSurfaceColor = .white
        scheme.colorScheme.backgroundColor = color
        scheme.colorScheme.onBackgroundColor = color
        return scheme
    }
    
    open class func cellColor() -> MDCContainerScheming {
        let colorScheme = MDCContainerScheme()
        guard let color = UIColor(named: "itembackGround") else { return colorScheme}
        colorScheme.colorScheme.primaryColor = color
        colorScheme.colorScheme.primaryColorVariant = color
        colorScheme.colorScheme.onPrimaryColor = color
        colorScheme.colorScheme.secondaryColor = color
        colorScheme.colorScheme.onSecondaryColor = color
        colorScheme.colorScheme.surfaceColor = color
        colorScheme.colorScheme.onSurfaceColor = color
        colorScheme.colorScheme.backgroundColor = color
        colorScheme.colorScheme.onBackgroundColor = color
        return colorScheme
    }
    
    open class func primaryColor() -> UIColor {
        guard let color = UIColor(named: "primaryColor") else { return .blue }
        return color
    }

    open class func SideMenuColor1() -> UIColor {
        guard let color = UIColor(named: "Color") else { return .blue }
        return color
    }
    
    open class func SideMenuColor2() -> UIColor {
        guard let color = UIColor(named: "Color-1") else { return .blue }
        return color
    }
    
    open class func SideMenuColor3() -> UIColor {
        guard let color = UIColor(named: "Color-2") else { return .blue }
        return color
    }
}
