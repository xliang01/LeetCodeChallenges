//
//  DivideTwoIntegers.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DivideTwoIntegers: Runnable {
    func runTests() {
        let solution = SolutionDivideBySubtraction()
        print(solution.divide(10, 3))
    }
    
    private class SolutionDivideBySubtraction {
        func divide(_ dividend: Int, _ divisor: Int) -> Int {
            // Abs on div
            var div = abs(dividend)
            // Abs on div by
            var by = abs(divisor)
            // Apply negative sign
            let neg = (dividend < 0 && divisor > 0) || (dividend > 0 && divisor < 0)
            // Count how many times divisor needs to be substracted before divident <= divisor. We're just subtracting divisor over and over again.
            var count = 0
            
            // Base cases
            if divisor == 1 { return dividend }
                // Zero divide by anything 0 is 0.
            else if dividend == 0 { return 0 }
                // Return 1 if both numbers are the same.
            else if dividend == divisor { return 1 }
                // Return 0 if divident is less than divide by. In integer division, a smaller number dividing a bigger number yields 0.
            else if div < by { return 0 }
            
            // While the divident is bigger, keep subtracting div by.
            while div >= by {
                var maxBy = by
                var timesToSubtractBy = 1
                
                // Keep doubling maxBy until it's greater than the div.
                while times2(maxBy) < div {
                    // Keep doubling to increase the amount of subtracts required.
                    maxBy = times2(maxBy)
                    // Keep count of how many subtracts are needed.
                    timesToSubtractBy = times2(timesToSubtractBy)
                }
                
                // Remove from div until div is <= div by.
                div -= maxBy
                count += timesToSubtractBy
            }
            
            // Check negative.
            count = neg ? -count : count
            
            if count > Int32.max {
                return Int(Int32.max)
            }
            else if count < Int32.min {
                return Int(Int32.min)
            }
            return count
        }
        
        private func times2(_ value: Int) -> Int {
            return value << 1
        }
    }
}
