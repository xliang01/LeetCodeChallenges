//
//  LeafSimilarTrees.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/31/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LeafSimilarTrees: Runnable {
    func runTests() {
        
    }
    
    /**
        T: O(T1 + T2) where T1 = Tree 1 nodes, and T2 = Tree 2 nodes.
        S: O(2^Log(T1) + 2^Log(T2)) where 2^Log(N) is the number of leaf nodes for the tree.
    */
    private class SolutionStack {
        func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
            if root1 == nil && root2 == nil { return true }
            guard let root1 = root1, let root2 = root2 else { return false }
            return leafVal(root1) == leafVal(root2)
        }
        
        private func leafVal(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            
            var leafs = [Int]()
            var stack = [TreeNode]()
            var curr: TreeNode? = node
            
            while curr != nil || !stack.isEmpty {
                while curr != nil {
                    stack.append(curr!)
                    curr = curr?.left
                }
                
                let top = stack.removeLast()
                curr = top.right
                if top.left == nil && top.right == nil {
                    leafs.append(top.val)
                }
            }
            return leafs
        }
    }
}
