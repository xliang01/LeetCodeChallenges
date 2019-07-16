//
//  NumberPool.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NumberPool: Runnable {
    func runTests() {
        // O 1
        // O 2
        // O 3
        // O 4
        // O 5
        // I 3
        // I 2
        // I 2
        // I 7
        // O 2
        // O 3
        // O 6
        // O 7
        // O 8
        
        let generator = NumberPoolGenerator()
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
        generator.IN(3)
        generator.IN(2)
        generator.IN(2)
        generator.IN(7)
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
        print(generator.OUT())
    }
    
    private class NumberPoolGenerator {
        var n = 0
        var heap = Heap<Int> { (lhs, rhs) -> Bool in return lhs < rhs }
        var set = Set<Int>()
        
        func IN(_ num: Int) {
            if num > n || set.contains(num) { return }
            heap.insert(num)
            set.insert(num)
        }
        
        func OUT() -> Int {
            if let minVal = heap.remove() {
                set.remove(minVal)
                return minVal
            }
            n += 1
            return n
        }
    }
}
