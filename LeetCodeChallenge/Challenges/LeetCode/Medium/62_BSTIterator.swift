//
//  62_BSTIterator.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/8/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class BSTIterator: Runnable {
    func runTests() {
        let solution = BSTStack(BSTIterator.sample1)
        print(solution.hasNext())   // T
        print(solution.next())      // 2
        print(solution.next())      // 4
        print(solution.next())      // 5
        print(solution.hasNext())   // T
        print(solution.next())      // 6
        print(solution.next())      // 8
        print(solution.next())      // 10
        print(solution.next())      // 12
        print(solution.hasNext())   // F
    }
    
    private static var sample1: TreeNode {
        let two = TreeNode(2)
        let five = TreeNode(5)
        let four = TreeNode(4)
        four.left = two
        four.right = five
        
        let twelve = TreeNode(12)
        let eight = TreeNode(8)
        let ten = TreeNode(10)
        ten.left = eight
        ten.right = twelve
        
        let six = TreeNode(6)
        six.left = four
        six.right = ten
        
        return six
    }
    
    /**
        Solution:
     
        We must used a controlled recursion. The only way to do this is with a stack. The stack allows us to pop off
        and step by step go through the recursion. Data structure used: Stack to manually traverse stack.
     
        Time complexity:
     
            next()
                O(1) because we always just get the latest value from the stack.
                O(h) on average since we only stack the left children, which is less and less as we traverse the tree.
                O(N) worst case if the tree is lopsided and all left nodes are less than the root.
            hasNext()
                O(1) because we're just checking if the stack is empty.
     
        Space Complexity:
            O(h) because on average, the stack holds at most the height of the tree.
    */
    private class BSTStack {
        var stack: [TreeNode] = []
        
        init(_ root: TreeNode?) {
            getLeft(root)
        }
    
        /** @return the next smallest number */
        func next() -> Int {
            let node = stack.popLast()!
            let val = node.val
            if let childRight = node.right {
                getLeft(childRight)
            }
            return val
        }
    
        /** @return whether we have a next smallest number */
        func hasNext() -> Bool {
            return !stack.isEmpty
        }
        
        private func getLeft(_ node: TreeNode?) {
            if node == nil { return }
            stack.append(node!)
            getLeft(node?.left)
        }
    }
}

