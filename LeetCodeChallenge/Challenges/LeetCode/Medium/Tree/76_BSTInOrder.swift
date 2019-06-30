//
//  76_BSTInOrder.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/13/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BSTInOrder: Runnable {
    
    private class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
        
        static var root: TreeNode {
            let one = TreeNode(1)
            let two = TreeNode(2)
            let three = TreeNode(3)
            
            two.left = three
            one.right = two
            return one
        }
    }

    func runTests() {
        let solution = SolutionBSTStack()
        print(solution.inorderTraversal(TreeNode.root))
    }
    
    private class SolutionBSTStack {
        func inorderTraversal(_ root: TreeNode?) -> [Int] {
            guard let root = root else { return [] }
            var stack = [TreeNode]()
            
            var values = [Int]()
            var currentNode: TreeNode? = root
            
            while currentNode != nil || !stack.isEmpty {
                // Get all of the in order LEFT nodes until we can no longer get them.
                while let node = currentNode {
                    stack.append(node)
                    currentNode = node.left
                }
                // Pop the last node from the stack. This is either the LEFT node, or the ROOT, or the RIGHT node in this order.
                let node = stack.removeLast()
                values.append(node.val)
                // Because this is in order, we still have to attempt to get all the LEFT nodes from the right node, so get the
                // right node and from above, push all its left nodes on the stack.
                currentNode = node.right
            }
            
            return values
        }
    }
}
