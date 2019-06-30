//
//  SmallestDifference.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SmallestDifference: Runnable {
    func runTests() {
        let solution = SolutionTargetRangeSorted()
        print(solution.smallestDifference([-1, 5, 10, 20, 28, 3], [26, 134, 135, 15, 17]))
    }
    
    private class SolutionTargetRangeSorted {
        func smallestDifference(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            // N Log N for Sort
            var nums1 = nums1.sorted()
            // M Log M for Sort
            var nums2 = nums2.sorted()
            
            var a1 = 0
            var a2 = 0
            var answer = [Int]()
            var smallest = Int.max
            
            // O(M + N)
            while a1 < nums1.count && a2 < nums2.count {
                let num1 = nums1[a1]
                let num2 = nums2[a2]
                let diff = abs(num1 - num2)
                
                if num1 == num2 { return [num1, num2] }
                else if num1 < num2 { a1 += 1 }
                else if num1 > num2 { a2 += 1 }
                
                if smallest > diff {
                    smallest = diff
                    answer = [num1, num2]
                }
            }
            
            return answer
        }
    }
}
