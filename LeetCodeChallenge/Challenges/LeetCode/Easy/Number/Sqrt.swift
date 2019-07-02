//
//  Sqrt.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class Sqrt: Runnable {
    func runTests() {
        let solution = SolutionBinarySearch()
        print(solution.sqrt(17))
    }
    
    private class SolutionBinarySearch {
        func sqrt(_ x: Int) -> Int {
            if x == 0 { return 0 }
            else if x <= 2 { return 1 }
            
            var left = 2
            var right = x / 2
            
            while left <= right {
                let mid = (left + right) / 2
                let square = mid * mid
                if square == x { return mid }
                else if square > x { right = mid - 1 }
                else if square < x { left = mid + 1 }
            }
            
            return right
        }
    }
}
