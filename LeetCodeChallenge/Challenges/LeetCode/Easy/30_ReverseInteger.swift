//
//  30_ReverseInteger.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ReverseInteger: Runnable {
    func runTests() {
        let solution = SolutionIterative()
        print(solution.reverse(1))
        print(solution.reverse(-1))
        print(solution.reverse(0))
        print(solution.reverse(12))
        print(solution.reverse(21))
        print(solution.reverse(10))
        print(solution.reverse(102))
        print(solution.reverse(1534236469))
    }
    
    private class SolutionIterative {
        
        // 2^31 - 1 = 2147483647
        // -2^31 = 2147483648
        
        // 120
        // 1..0 = 0 * 100 + 1 * 1 = 1
        // 2 = 2 * 10 = 20
        
        // 1231
        // 1...1 = 1 * 1000 + 1 * 1 = 1001
        // 23 = 3 * 100 + 2 * 10 = 320
        
        // 1201
        // 1...1 = 1 * 1000 + 1 * 1 = 1001
        // 20 = 0 * 100 + 2 * 10 = 20
        
        // 123456
        // 1....6 = 6 * 100000 + 1 * 1 = 600001
        // 2345 = 5 * 10000 + 2 * 10 =    50020
        // 34 = 3 * 1000 + 4 * 100 =       3400
        
        func reverse(_ x: Int) -> Int {
            var absX = abs(x)
            // If the number is between 0 and 10, just return the number as is.
            if absX >= 0 && absX < 10 {
                return x
            }
            // Mark if negative.
            let isNegative = x < 0
            // Find out how many tens are in the number. This is used to extract the outer digits.
            var tens = 1
            while (absX / tens) >= 10 {
                tens *= 10
            }
            // This multiplier is used to ensure the right most digit is increased appropriately.
            var multiplier = 1
            // This is the final sum that's the reversed number using sums.
            var sum = 0
            
            while absX != 0 {
                // If the number is resolved to be less than 10, just multiple by tens. 121 resolves to 11, and 2. Here, 2 * 10 = 20.
                if absX < 10 {
                    sum += absX * tens
                }
                // If the resolved number is >= 10, then extract the left and right digits, and add them up for the reverse.
                else {
                    let remainder = absX % 10
                    let multiple = absX / tens
                    // This is the reverse number because the remainder can multiply by the tens, and the multiple is decreased by the
                    // multiplier.
                    sum += (remainder * tens) + (multiple * multiplier)
                }
                // Remove the other edges of the numbers.
                absX = (absX % tens) / 10
                // Divide by 10 to ensure we can extract and process the left most digit correctly.
                tens /= 10
                // Update the multiplier to calculate the right most digit correctly.
                multiplier *= 10
            }
            sum = isNegative ? -1 * sum : sum
            if sum > Int32.max || sum < Int32.min {
                return 0
            }
            return sum
        }
    }
}
