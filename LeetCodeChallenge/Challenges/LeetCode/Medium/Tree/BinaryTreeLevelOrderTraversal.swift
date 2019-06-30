//
//  BinaryTreeLevelOrderTraversal.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BTLevelOrderTraversal: Runnable {
    func runTests() {
        
    }
    
    // Definition for a binary tree node.
    private class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    private class Solution {
        func levelOrder(_ root: TreeNode?) -> [[Int]] {
            guard let root = root else { return [] }
            
            var queue = [(Int, TreeNode)]()
            var answer = [[Int]]()
            var prevLevel = 1
            
            queue.append((prevLevel, root))
            answer.append([])
            
            while !queue.isEmpty {
                let (currLevel, node) = queue.removeFirst()
                
                if currLevel == prevLevel {
                    answer[answer.count-1].append(node.val)
                }
                else {
                    answer.append([node.val])
                }
                
                if let left = node.left {
                    queue.append((currLevel + 1, left))
                }
                if let right = node.right {
                    queue.append((currLevel + 1, right))
                }
                prevLevel = currLevel
            }
            
            return answer
        }
    }
}
