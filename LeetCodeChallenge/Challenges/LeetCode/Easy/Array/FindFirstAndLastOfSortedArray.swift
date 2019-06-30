//
//  FindFirstAndLastOfSortedArray.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class FindFirstAndLastOfSortedArray: Runnable {
    func runTests() {
        let solution = SolutionBinarySearch()
        print(solution.searchRange([5,7,7,8,8,10], 8))
    }
    
    private class SolutionBinarySearch {
        func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
            var answer = [-1, -1]
            binarySearch(nums, 0, nums.count-1, target, &answer)
            return answer
        }
        
        private func binarySearch(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int, _ answer: inout [Int]) {
            if start > end { return }
            
            let mid = (start + end) / 2
            
            if nums[mid] == target {
                if answer[0] == -1 {
                    answer[0] = mid
                    answer[1] = mid
                }
                else if mid > answer[1] { answer[1] = mid }
                else if mid < answer[0] { answer[0] = mid }
                
                binarySearch(nums, start, mid-1, target, &answer)
                binarySearch(nums, mid+1, end, target, &answer)
            }
            else if nums[mid] > target {
                binarySearch(nums, start, mid-1, target, &answer)
            }
            else {
                binarySearch(nums, mid+1, end, target, &answer)
            }
        }
    }
}
