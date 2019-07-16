//
//  UnivalTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/16/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class UnitvalTree: Runnable {
    func runTests() {
        
    }
    
    private class SolutionBFS {
        func isUnivalTree(_ root: TreeNode?) -> Bool {
            guard let root = root else { return false }
            
            var queue = [(TreeNode, Int)]()
            queue.append((root, root.val))
            
            while !queue.isEmpty {
                let (node, val) = queue.removeFirst()
                if node.val != val { return false }
                
                if let left = node.left {
                    queue.append((left, node.val))
                }
                
                if let right = node.right {
                    queue.append((right, node.val))
                }
            }
            
            return true
        }
    }
    
    private class SolutionDFS {
        func isUnivalTree(_ root: TreeNode?) -> Bool {
            guard let root = root else { return false }
            return dfs(root, root.val)
        }
        
        func dfs(_ root: TreeNode?, _ val: Int) -> Bool {
            guard let root = root else { return true }
            if root.val != val { return false }
            return dfs(root.left, root.val) && dfs(root.right, root.val)
        }
    }
}
