//
//  MaxBinaryTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoMaxBinaryTree: Runnable {
    func runTests() {
        
    }
    
    private class MaxBinaryTreeRecursion {
        public class TreeNode {
            public var val: Int
            public var left: TreeNode?
            public var right: TreeNode?
            public init(_ val: Int) {
                self.val = val
                self.left = nil
                self.right = nil
            }
        }
        
        private func getMaxPath(_ node: TreeNode?) -> Int {
            return 0
        }
        
        private func getMaxPathSum(_ node: TreeNode?) -> (Int, Int) {
            guard let node = node else { return (0, 0) }
            let (justLeftBranchesMax, entireLeftSubtreeMax) = getMaxPathSum(node.left)
            let (justRightBranchesMax, entireRightSubtreeMax) = getMaxPathSum(node.right)
            
            // Get max of just the left or right branch.
            let justBranchesMax = max(justLeftBranchesMax,
                                      justRightBranchesMax)
            // Get max of just the left or right branch with the current node val.
            let justBranchesWithRootMax = max(node.val, node.val + justBranchesMax)
            
            // Compare just the branches with the root, or the entire subtree.
            let entireSubTreeMaxWithRoot = max(justBranchesWithRootMax,
                                               node.val + justLeftBranchesMax + justRightBranchesMax)
            // Compare just the sub trees with the current subtree.
            let runningMaxSubTree = max(entireLeftSubtreeMax,
                                        entireRightSubtreeMax,
                                        entireSubTreeMaxWithRoot)
            
            return (justBranchesWithRootMax, runningMaxSubTree)
        }
    }
}
