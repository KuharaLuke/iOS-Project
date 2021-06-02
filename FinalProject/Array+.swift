//
//  Array+.swift
//  Lecture3
//
//  Created by Luke Kuhara on 2021/3/19.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
}
