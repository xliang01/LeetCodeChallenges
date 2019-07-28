//
//  Intersection.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class Intersection: Runnable {
    func runTests() {
        let solution = SolutionTwoPointers()
        print(solution.intersection([1,2,2,1], [2,2]))
    }
    
    private class SolutionTwoPointers {
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            var ans = Set<Int>()
            var nums1 = nums1
            var nums2 = nums2
            
            nums1.sort()
            nums2.sort()
            
            var idx1 = 0
            var idx2 = 0
            
            while idx1 < nums1.count && idx2 < nums2.count {
                let val1 = nums1[idx1]
                let val2 = nums2[idx2]
                if val1 == val2 {
                    if !ans.contains(val1) { ans.insert(val1) }
                    idx1 += 1
                    idx2 += 1
                }
                else if val2 < val1 { idx2 += 1 }
                else { idx1 += 1 }
            }
            
            return Array(ans)
        }
    }
    
    private class SolutionSet {
        func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
            let set = Set(nums2)
            var ans = Set<Int>()
            for n in nums1 {
                if set.contains(n) {
                    ans.insert(n)
                }
            }
            return Array(ans)
        }
    }
}
