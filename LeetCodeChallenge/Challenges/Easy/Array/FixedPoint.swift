//
//  FixedPoint.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FixedPoint: Runnable {
    func runTests() {
        let solution = SolutionBinarySearch()
        print(solution.fixedPoint([-10,-5,0,3,7]))
    }
    
    private class SolutionBinarySearch {
        func fixedPoint(_ A: [Int]) -> Int {
            return findIndex(A, 0, A.count-1)
        }
        
        private func findIndex(_ A: [Int], _ start: Int, _ end: Int) -> Int {
            if start > end {
                return -1
            }
            let mid = (start + end) / 2
            if A[mid] == mid {
                return mid
            }
            else if mid < A[mid] {
                return findIndex(A, start, mid - 1)
            }
            else {
                return findIndex(A, mid + 1, end)
            }
            return -1
        }
    }
}
