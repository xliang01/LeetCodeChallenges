//
//  9_NRepeated.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class NRepeated: Runnable {
    func runTests() {
        let solution1 = SolutionSplitFind()
        print(solution1.repeatedNTimes([1,2,3,3]))
        print(solution1.repeatedNTimes([2,1,2,5,3,2]))
        print(solution1.repeatedNTimes([5,1,5,2,5,3,5,4]))
        
        let solution2 = SolutionReverseSearch()
        print(solution2.repeatedNTimes([1,2,3,3]))
        print(solution2.repeatedNTimes([2,1,2,5,3,2]))
        print(solution2.repeatedNTimes([5,1,5,2,5,3,5,4]))
    }
    
    /**
        Solution is to find any number that's a duplicate, and then immediately fire.
     
        Performance:
     
        Runtime Complexity: O(N)
        Space Complexity: O(N)
     */
    private class SolutionSplitFind {
        func repeatedNTimes(_ A: [Int]) -> Int {
            var count = Set<Int>()
            for number in A {
                if count.contains(number) {
                    return number
                }
                else {
                    count.insert(number)
                }
            }
            return 0
        }
    }
    
    private class SolutionReverseSearch {
        func repeatedNTimes(_ A: [Int]) -> Int {
            for i in (2..<A.count) {
                if A[i] == A[i - 1] || A[i] == A[i - 2] {
                    return A[i]
                }
            }
            return A[0]
        }
    }
}

