//
//  BinarySearchTreeInOrderTraversal.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/29/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BinarySearchTreeInOrderTraversal: Runnable {
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
    
    private class BSTIterator {
        var stack = [TreeNode]()
        
        init(_ root: TreeNode?) {
            guard let root = root else { return }
            // Appends root.
            stack.append(root)
            // Appends all of the left side for the InOrder traversal.
            var left = root.left
            while left != nil {
                stack.append(left!)
                left = left!.left
            }
        }
        
        /** @return the next smallest number */
        func next() -> Int {
            let node = stack.removeLast()
            
            // Check if there's a right. If there is, then get all of it, while the root is popped.
            if let right = node.right {
                stack.append(right)
                var left = right.left
                while left != nil {
                    stack.append(left!)
                    left = left!.left
                }
            }
            
            return node.val
        }
        
        /** @return whether we have a next smallest number */
        func hasNext() -> Bool {
            return !stack.isEmpty
        }
    }
    
    /**
     * Your BSTIterator object will be instantiated and called as such:
     * let obj = BSTIterator(root)
     * let ret_1: Int = obj.next()
     * let ret_2: Bool = obj.hasNext()
     */
}
