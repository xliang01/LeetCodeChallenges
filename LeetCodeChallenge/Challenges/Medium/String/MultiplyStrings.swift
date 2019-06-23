//
//  MultiplyStrings.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MultiplyStrings: Runnable {
    func runTests() {
        let solution = SolutionProduct()
        print(solution.multiply("12", "34"))
        
    }
    
    private class SolutionProduct {
        func multiply(_ num1: String, _ num2: String) -> String {
            let num1 = Array<Character>(num1)
            let num2 = Array<Character>(num2)
            let l1 = num1.count
            let l2 = num2.count
            let s1 = zip(num1, 0..<l1).reversed()
            let s2 = zip(num2, 0..<l2).reversed()
            var digits = Array(repeating: 0, count: l1 + l2)
            
            // 12
            // 34
            
            // 21
            // 43
            //    80
            
            for (c1, i) in s1 {
                for (c2, j) in s2 {
                    let product = Int(String(c1))! * Int(String(c2))!
                    let pos1 = i + j
                    let pos2 = pos1 + 1
                    let sum = product + digits[pos2]
                    
                    digits[pos1] += sum / 10;
                    digits[pos2] = (sum) % 10;
                }
            }
            
            // slower due to 3 separate passes over the array
        // let result = digits.reduce([], {(partial, val) in partial.isEmpty && val == 0 ? partial : partial + [val]}).map{String($0)}.joined()
            var result = ""
            for val in digits {
                if !(result.isEmpty && val == 0) {
                    result.append(String(val))
                }
            }
            
            return result.isEmpty ? "0" : result
        }
    }
}
