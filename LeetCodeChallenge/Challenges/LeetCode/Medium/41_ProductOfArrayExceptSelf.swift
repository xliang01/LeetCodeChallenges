//
//  41_ProductOfArrayExceptSelf.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ProductOfArrayExceptSelf: Runnable {
    func runTests() {
        let solution1 = SolutionMatrix()
        print(solution1.productExceptSelf([1, 2, 3, 4]))
    }
    
    private class SolutionMatrix {
        func productExceptSelf(_ nums: [Int]) -> [Int] {
            var prod = 1
            var result = Array(repeating: 1, count: nums.count)
            
            for i in 0..<nums.count{
                result[i] = prod
                prod *= nums[i]
            }
            
            prod = 1
            for i in stride(from: nums.count - 1, to: -1, by: -1){
                result[i] *= prod
                prod *= nums[i]
            }
            return result
        }
    }
}
