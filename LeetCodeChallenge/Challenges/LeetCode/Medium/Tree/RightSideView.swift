//
//  RightSideView.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RightSideView: Runnable {
    func runTests() {
        
    }
    
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
    
    private class SolutionBFS {
        func rightSideView(_ root: TreeNode?) -> [Int] {
            guard let root = root else { return [] }
            
            var answers = [Int]()
            var visited = Set<Int>()
            var queue = [(Int, TreeNode)]()
            queue.append((0, root))
            
            while !queue.isEmpty {
                let (level, node) = queue.removeFirst()
                
                if !visited.contains(level) {
                    answers.append(node.val)
                    visited.insert(level)
                }
                
                if let right = node.right {
                    queue.append((level + 1, right))
                }
                
                if let left = node.left {
                    queue.append((level + 1, left))
                }
            }
            
            return answers
        }
    }
}
