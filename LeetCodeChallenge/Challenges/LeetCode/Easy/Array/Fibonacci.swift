//
//  Fibonacci.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class Fibonacci: Runnable {
    func runTests() {
        let solution = SolutionDP()
        print(solution.fib(20))
    }
    
    private class SolutionDP {
        func fib(_ N: Int) -> Int {
            if N < 2 { return N }
            
            var sum = 0
            var prev = 0
            var curr = 1
            //0, 1, 2, 3, 4, 5
            //0, 1, 1, 2, 3, 5
            for _ in 2...N {
                sum = curr + prev
                prev = curr
                curr = sum
            }
            
            return sum
        }
    }
}
