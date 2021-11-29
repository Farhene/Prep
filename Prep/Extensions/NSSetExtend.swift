//
//  NSSetExtend.swift
//  Prep
//
//  Created by Farhene Sultana on 11/29/21.
//

import Foundation

//Borrowed from TitanWolf.org to convert NSSet item to array object
extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}
