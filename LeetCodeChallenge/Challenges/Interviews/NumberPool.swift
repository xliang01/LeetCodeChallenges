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
    
    }
    
    private class SolutionHeap {
        var heap = Heap<Int> { (lhs, rhs) -> Bool in
            return lhs < rhs
        }
    }
}
