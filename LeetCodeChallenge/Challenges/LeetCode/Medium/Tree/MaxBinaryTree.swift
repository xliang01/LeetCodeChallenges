//
//  MaxBinaryTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

private class MaxBinaryTree: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        print(solution.constructMaximumBinaryTree([3,2,1,6,0,5])?.preOrder ?? "")
    }
    
    private class SolutionDFS {
        func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
            return constructMaxBT(nums, 0, nums.count-1)
        }
        
        private func constructMaxBT(_ nums: [Int],
                                    _ start: Int,
                                    _ end: Int) -> TreeNode? {
            if start > end { return nil }
            else if start == end { return TreeNode(nums[start]) }
            
            let idx = findMaxIdx(nums, start, end)
            let node = TreeNode(nums[idx])
            
            node.left = constructMaxBT(nums,
                                       start,
                                       idx - 1)
            
            node.right = constructMaxBT(nums,
                                        idx + 1,
                                        end)
            return node
        }
        
        private func findMaxIdx(_ nums: [Int],
                                _ start: Int,
                                _ end: Int) -> Int {
            var maxIdx = 0
            var maxVal = Int.min
            
            for i in (start...end) {
                if nums[i] > maxVal {
                    maxVal = nums[i]
                    maxIdx = i
                }
            }
            return maxIdx
        }
    }
}
