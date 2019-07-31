//
//  IncreasingOrderTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/31/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class IncreasingOrderTree: Runnable {
    func runTests() {
        
    }
    
    private class SolutionDFS {
        func increasingBST(_ root: TreeNode?) -> TreeNode? {
            var prev: TreeNode? = TreeNode(-1)
            let head = prev
            dfs(root, &prev)
            return head?.right
        }
        
        func dfs(_ node: TreeNode?, _ prev: inout TreeNode?) {
            guard let node = node else { return }
            
            dfs(node.left, &prev)
            node.left = nil
            prev?.right = node
            prev = node
            dfs(node.right, &prev)
        }
    }
    
    private class SolutionBFS {
        func bfs(_ root: TreeNode?) -> TreeNode? {
            guard let root = root else { return nil }
            var stack = [TreeNode]()
            var curr: TreeNode? = root
            var prev: TreeNode? = TreeNode(-1)
            let head: TreeNode? = prev
            
            while curr != nil || !stack.isEmpty {
                while curr != nil {
                    stack.append(curr!)
                    curr = curr?.left
                }
                
                let node = stack.removeLast()
                curr = node.right
                
                node.left = nil
                prev?.right = node
                prev = node
            }
            return head?.right
        }
    }
}
