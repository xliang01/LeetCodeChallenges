//
//  SortedArrayToBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 8/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SortedArrayToBST: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        print(solution.sortedArrayToBST([1,2,3,4,5,6,7,8,9])?.inOrder ?? "")
    }
    
    private class SolutionDFS {
        func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
            return sortedArrayToBST(nums, 0, nums.count-1)
        }
        
        private func sortedArrayToBST(_ nums: [Int],
                              _ left: Int,
                              _ right: Int) -> TreeNode? {
            guard left <= right else { return nil }
            
            let mid = (left + right) / 2
            let node = TreeNode(nums[mid])
            node.left = sortedArrayToBST(nums, left, mid-1)
            node.right = sortedArrayToBST(nums, mid+1, right)
            return node
        }
    }
}
