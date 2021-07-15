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
        let color = #colorLiteral(red: 0.3882352941, green: 0.8784313725, blue: 0.7803921569, alpha: 1)
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
        let color = #colorLiteral(red: 0.3882352941, green: 0.8784313725, blue: 0.7803921569, alpha: 1)
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
        let color = #colorLiteral(red: 0.5215686275, green: 0.9607843137, blue: 0.9254901961, alpha: 1)
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
        return #colorLiteral(red: 0.3882352941, green: 0.8784313725, blue: 0.7803921569, alpha: 1)
    }
    
    open class func borderColor() -> UIColor {
        return #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
    }
    
    open class func barTintColor() -> UIColor {
        return #colorLiteral(red: 0.7098039216, green: 0.9607843137, blue: 0.9254901961, alpha: 1)
    }
    
    open class func addProductTextField() -> UIColor {
        return #colorLiteral(red: 0.9411764706, green: 0.9529411765, blue: 0.9568627451, alpha: 1)
    }

    open class func SideMenuColor1() -> UIColor {
        return #colorLiteral(red: 0.3882352941, green: 0.8784313725, blue: 0.7803921569, alpha: 1)
    }
    
    open class func SideMenuColor2() -> UIColor {
        return #colorLiteral(red: 0.1882352941, green: 0.6745098039, blue: 0.7019607843, alpha: 1)
    }
    
    open class func SideMenuColor3() -> UIColor {
        return #colorLiteral(red: 0.2862745098, green: 0.6196078431, blue: 0.8980392157, alpha: 1)
    }
}
