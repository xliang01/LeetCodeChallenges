//
//  RelativeSortArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/15/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RelativeSortArray: Runnable {
    func runTests() {
        let solution = SolutionHashMapCountWithKeySort()
        let arr1 = [2,21,43,38,0,42,33,7,24,13,12,27,12,24,5,23,29,48,30,31]
        let arr2 = [2,42,38,0,43,21]
        print(solution.relativeSortArray(arr1, arr2))
    }
    
    private class SolutionHashMapCountWithKeySort {
        func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
            var counts = [Int: Int]()
            for n in arr1 { counts[n, default: 1] = (counts[n] ?? 0) + 1 }
            
            var ans = [Int](repeating: 0, count: arr1.count)
            var idx = 0
            
            for n in arr2 {
                fill(n, &ans, &idx, &counts)
            }
            
            let keys = counts.keys.sorted()
            for k in keys {
               fill(k, &ans, &idx, &counts)
            }
            
            return ans
        }
        
        private func fill(_ value: Int,
                          _ array: inout [Int],
                          _ index: inout Int,
                          _ counts: inout [Int: Int]) {
            if var numCount = counts[value] {
                while numCount > 0 {
                    array[index] = value
                    index += 1
                    numCount -= 1
                }
                counts.removeValue(forKey: value)
            }
        }
    }
    
    private class SolutionPointerArray {
        func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
            var swapIdx = 0
            var arr1 = arr1
            var heap = Heap<Int>(sort: { $0 < $1 })
            
            for n in arr2 {
                var i = swapIdx
                while i < arr1.count {
                    if arr1[i] == n {
                        swap(&arr1, i, swapIdx)
                        swapIdx += 1
                    }
                    i += 1
                }
            }
            
            var tmpIdx = swapIdx
            while tmpIdx < arr1.count {
                heap.insert(arr1[tmpIdx])
                tmpIdx += 1
            }
            
            while swapIdx < arr1.count, !heap.isEmpty {
                arr1[swapIdx] = heap.remove()!
                swapIdx += 1
            }
            
            return arr1
        }
        
        private func swap(_ array: inout [Int], _ i: Int, _ j: Int) {
            let temp = array[i]
            array[i] = array[j]
            array[j] = temp
        }
    }
}
