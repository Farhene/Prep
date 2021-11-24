//
//  UIColorExtend.swift
//  Prep
//
//  Created by Farhene Sultana on 11/23/21.
//  Sources:
//          lines 13-27: https://www.youtube.com/watch?v=JI7-f3c1eEM

import UIKit

extension UIColor {
    
    //My theme colors here:
    static let darkTeal = UIColor(hexCode: 0x009999)
    static let darkestTeal = UIColor(hexCode: 0x006666)
    static let lightTeal = UIColor(hexCode: 0x99FFCC)
    static let lightestTeal = UIColor(hexCode: 0xe9fcf6)
    static let medTeal = UIColor(hexCode: 0x00CC99)
    
    static let cutePink = UIColor(hexCode: 0xFF99CC)
    static let lightPink = UIColor(hexCode: 0xFFCCFF)
    static let dullPink = UIColor(hexCode: 0xCC6699)
    static let bloodRed = UIColor(hexCode: 0x800000)
    
    static let lightOrange = UIColor(hexCode: 0xFFCC66)
    static let coral = UIColor(hexCode: 0xFF5050)
    static let lemon = UIColor(hexCode: 0xFFFF66)
    
    static let skyBlue = UIColor(hexCode: 0x66CCFF)
    static let midSkyBlue = UIColor(hexCode: 0x0099FF)
    static let lightLavender = UIColor(hexCode: 0x9999FF)
    static let waluigi = UIColor(hexCode: 0x9933FF)

    static let uglyGreen = UIColor(hexCode: 0x99CC00)
    static let deepGreen = UIColor(hexCode: 0x009933)
    
    convenience init(red : Int, green : Int, blue : Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hexCode: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hexCode >> 16) & 0xFF,
            green: (hexCode >> 8) & 0xFF,
            blue: hexCode & 0xFF,
            alpha: alpha
        )
    }
}


