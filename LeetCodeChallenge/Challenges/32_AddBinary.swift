//
//  32_AddBinary.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AddBinary: Runnable {
    func runTests() {
        let solution = SolutionIterative()
        print(solution.addBinary("101", "1"))
        print(solution.addBinary("11", "1"))
        print(solution.addBinary("0", "1"))
        print(solution.addBinary("10", "1"))
    }
    
    private class SolutionIterative {
        func addBinary(_ a: String, _ b: String) -> String {
            var aBinary = Array<Character>(a)
            var bBinary = Array<Character>(b)
            var sum = ""
            
            var carry = false
            while !aBinary.isEmpty || !bBinary.isEmpty {
                let aValue = aBinary.popLast() == "1" ? 1 : 0
                let bValue = bBinary.popLast() == "1" ? 1 : 0
                let sumValue = aValue + bValue + (carry ? 1 : 0)
                
                var value: String
                if sumValue >= 2 {
                    value = sumValue > 2 ? "1" : "0"
                    carry = true
                }
                else {
                    value = "\(sumValue)"
                    carry = false
                }
                sum = value + sum
            }
            if carry {
                sum = "1" + sum
            }
            return sum
        }
    }
}
