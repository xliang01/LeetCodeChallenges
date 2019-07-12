//
//  17_MergeBinaryTrees.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
    Given two binary trees and imagine that when you put one of them to cover the other, some nodes of the two trees are overlapped while the others are not.
 
    You need to merge them into a new binary tree. The merge rule is that if two nodes overlap, then sum node values up as the new value of the merged node. Otherwise, the NOT null node will be used as the node of new tree.
 
     Input:
         Tree 1                     Tree 2
          1                         2
         / \                       / \
        3   2                     1   3
       /                           \   \
      5                             4   7
 
     Output:
     Merged tree:
         3
        / \
       4   5
      / \   \
     5   4   7
 */
class MergeBinaryTrees: Runnable {
    /**
     * Definition for a binary tree node.
     */
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
    
    func runTests() {
        let solution1 = SolutionNewNodeReference()
        var mergedTree = solution1.mergeTrees(tree1, tree2)
        print(mergedTree)
        
        let solution2 = SolutionNewNodeExistingReference()
        mergedTree = solution2.mergeTrees(tree1, tree2)
        print(mergedTree)
        
        let solution3 = SolutionNewNodeMergeReference()
        mergedTree = solution3.mergeTrees(tree1, tree2)
        print(mergedTree)
    }
    
    private class SolutionNewNodeReference {
        func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
            var treeNode: TreeNode? = nil
            
            if let t1 = t1, let t2 = t2 {
                treeNode = TreeNode(t1.val + t2.val)
                treeNode?.left = mergeTrees(t1.left, t2.left)
                treeNode?.right = mergeTrees(t1.right, t2.right)
            }
            else if let t1 = t1 {
                treeNode = TreeNode(t1.val)
                treeNode?.left = mergeTrees(t1.left, nil)
                treeNode?.right = mergeTrees(t1.right, nil)
            }
            else if let t2 = t2 {
                treeNode = TreeNode(t2.val)
                treeNode?.left = mergeTrees(nil, t2.left)
                treeNode?.right = mergeTrees(nil, t2.right)
            }
            return treeNode
        }
    }
    
    private class SolutionNewNodeExistingReference {
        func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
            var treeNode: TreeNode? = nil
            
            if let t1 = t1, let t2 = t2 {
                treeNode = TreeNode(t1.val + t2.val)
                treeNode?.left = mergeTrees(t1.left, t2.left)
                treeNode?.right = mergeTrees(t1.right, t2.right)
                return treeNode
            }
            return t1 ?? t2
        }
    }
    
    private class SolutionNewNodeMergeReference {
        /**
            Solution:
         
            Test if both nodes exist. If they do, combine the node value and assign to the left tree node.
            This saves memory because we are not creating any new nodes.
         
            If both nodes do not exist, there's nothing to merge. Just return which ever node exists to ensure
            the rest of the tree is retained.
         
            Performance:
         
            Runtime complexity: O(N) If every node can be merged with a trees that have N elements.
            Space complexity: O(1) since no new data structures are used.
         
            Note: Because we are returning direct references from the original tree nodes. Therefore any
            updates to these tree nodes will affect the original.
        */
        func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
            if let t1 = t1, let t2 = t2 {
                t1.val = t1.val + t2.val
                t1.left = mergeTrees(t1.left, t2.left)
                t1.right = mergeTrees(t1.right, t2.right)
                return t1
            }
            return t1 ?? t2
        }
    }
    
    private var tree1: TreeNode {
        let one = TreeNode(1)
        let three = TreeNode(3)
        let two = TreeNode(2)
        let five = TreeNode(5)
        
        three.left = five
        one.left = three
        one.right = two
        
        return one
    }
    
    private var tree2: TreeNode {
        let one = TreeNode(1)
        let two = TreeNode(2)
        let three = TreeNode(3)
        let four = TreeNode(4)
        let seven = TreeNode(7)
        
        one.right = four
        three.right = seven
        two.left = one
        two.right = three
        
        return two
    }
}
