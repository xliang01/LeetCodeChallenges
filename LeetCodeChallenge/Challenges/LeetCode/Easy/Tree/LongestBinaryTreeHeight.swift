//
//  LongestBinaryTreeHeight.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LongestBinaryTreeHeight: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        print(solution.longestHeight(LongestBinaryTreeHeight.testNode))
    }
    
    private static var testNode: TreeNode {
        let zero = TreeNode(0)
        let one = TreeNode(1)
        let two = TreeNode(2)
        let three = TreeNode(3)
        let four = TreeNode(4)
        let five = TreeNode(5)
        
        four.right = five
        two.left = three
        two.right = four
        zero.left = one
        zero.right = two
        
        return zero
    }
    
    private class SolutionDFS {
        func longestHeight(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            return dfs(node)
        }
        
        private func dfs(_ node: TreeNode?) -> Int {
            guard let node = node else { return -1 }
            
            return max(dfs(node.left) + 1,
                       dfs(node.right) + 1)
        }
    }
    
    private class SolutionBFS {
        func longestHeight(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            var queue = [(node: TreeNode, level: Int)]()
            queue.append((node, 0))
            
            var maxLevel = Int.min
            while !queue.isEmpty {
                let (node, level) = queue.removeFirst()
                maxLevel = max(maxLevel, level)
                
                if let left = node.left {
                    queue.append((left, level + 1))
                }
                
                if let right = node.right {
                    queue.append((right, level + 1))
                }
            }
            return maxLevel
        }
    }
}
