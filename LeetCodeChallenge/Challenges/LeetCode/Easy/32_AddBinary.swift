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
    
    private class SolutionIterativeFaster {
        /**
            Solution:
         
            Convert the binary strings into an array of integers. Then use a carry variable and ensure
            as the numbers are added, the carry flag is converted to 1 or 0. Then as each variable is
            added together with the carry, prepend either 0 or 1.
         
            Performance:
         
            Time Complexity: O(N) because we have iterate through the entire string.
            Space Complexity: O(N) because we have to copy the contents of the string into integer arrays.
         */
        func addBinary(_ a: String, _ b: String) -> String {
            var aBinary = Array<Character>(a).map { Int(String($0))! }
            var bBinary = Array<Character>(b).map { Int(String($0))! }
            var sum = ""
            
            var carry = 0
            while !aBinary.isEmpty || !bBinary.isEmpty {
                let aValue = aBinary.popLast()
                let bValue = bBinary.popLast()
                let sumValue = (aValue ?? 0) + (bValue ?? 0) + carry
                carry = sumValue >= 2 ? 1 : 0
                sum = "\(sumValue % 2)" + sum
            }
            
            if carry == 1 {
                sum = "1" + sum
            }
            
            return sum
        }
    }
}
