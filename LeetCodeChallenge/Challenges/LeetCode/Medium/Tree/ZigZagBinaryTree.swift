//
//  ZigZagBinaryTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ZigZagLevelOrderTraversal: Runnable {
    func runTests() {
        let solution = SolutionTwoStacks()
        print(solution.zigzagLevelOrder(nil))
    }
    
    /**
        Use two stacks to interchange the values.
        T: O(N)
        S: O(N)
     */
    private class SolutionTwoStacks {
        func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
            guard let root = root else { return [] }
            
            var leftStack = [TreeNode]()
            var rightStack = [TreeNode]()
            var answers = [[Int]]()
            
            leftStack.append(root)
            
            while !leftStack.isEmpty || !rightStack.isEmpty {
                let l = manageStack(&leftStack, &rightStack, false)
                let r = manageStack(&rightStack, &leftStack, true)
                
                if !l.isEmpty { answers.append(l) }
                if !r.isEmpty { answers.append(r) }
            }
            
            return answers
        }
        
        private func manageStack(_ stack1: inout [TreeNode],
                                 _ stack2: inout [TreeNode],
                                 _ leftToRight: Bool) -> [Int] {
            var answers = [Int]()
            
            while !stack1.isEmpty {
                let node = stack1.removeLast()
                answers.append(node.val)
                let node1 = leftToRight ? node.right : node.left
                let node2 = leftToRight ? node.left : node.right
                if let node1 = node1 { stack2.append(node1) }
                if let node2 = node2 { stack2.append(node2) }
            }
            return answers
        }
    }
}
