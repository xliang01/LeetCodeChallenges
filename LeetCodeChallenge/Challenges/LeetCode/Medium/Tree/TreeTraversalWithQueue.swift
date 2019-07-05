//
//  TreeTraversal.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TreeTraversalWithQueue: Runnable {
    func runTests() {
        let solution = SolutionStack()
        print(solution.traversePreOrder(TreeNode.root))
        print(solution.traverseInOrder(TreeNode.root))
//        print(solution.traversePostOrder(TreeNode.root))
        
        readLine(strippingNewline: true)
    }
    
    private class SolutionStack {
        // Root, Left, Right
        func traversePreOrder(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            var answers = [Int]()
            var stack = [TreeNode]()
            stack.append(node)
            
            while !stack.isEmpty {
                let root = stack.removeLast()
                answers.append(root.val)
                
                if let right = root.right {
                    stack.append(right)
                }
                
                if let left = root.left {
                    stack.append(left)
                }
            }
            
            return answers
        }
        
        func traverseInOrder(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            var answers = [Int]()
            var stack = [TreeNode]()
            var curr: TreeNode? = node
            
            while curr != nil || !stack.isEmpty {
                while curr != nil {
                    stack.append(curr!)
                    curr = curr?.left
                }
                
                let node = stack.removeLast()
                answers.append(node.val)
                curr = node.right
            }
            
            return answers
        }
        
        // Left, Right, Root
        func traversePostOrder(_ node: TreeNode?) -> [Int] {
            guard let node = node else { return [] }
            var answers = [Int]()
            var stack = [TreeNode]()
            stack.append(node)
            
            while !stack.isEmpty {
                let node = stack.last!
                var left = node.left
                
                while left != nil {
                    stack.append(left!)
                    left = left!.left
                }
                
                if let right = node.right {
                    stack.append(right)
                }
                
                answers.append(stack.removeLast().val)
            }
            
            return answers
        }
        
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
        
        static var root: TreeNode {
            let four = TreeNode(4)
            let five = TreeNode(5)
            let seven = TreeNode(7)
            let eight = TreeNode(8)
            let nine = TreeNode(9)
            let ten = TreeNode(10)
            let eleven = TreeNode(11)
            
            /**
                  5
                /   \
               4     9
                    / \
                   8  10
                  /     \
                 7      11
            */
            ten.right = eleven
            eight.left = seven
            nine.left = eight
            nine.right = ten
            five.left = four
            five.right = nine
            return five
        }
        
        var postOrderValues: String {
            return TreeNode.postOrder(self)
        }
        
        var inOrderValues: String {
            return TreeNode.inOrder(self)
        }
        
        private static func postOrder(_ node: TreeNode?) -> String {
            guard let node = node else { return "null" }
            var strings = [String]()
            strings.append(postOrder(node.left))
            strings.append(postOrder(node.right))
            strings.append(String(node.val))
            return strings.joined(separator: ";")
        }
        
        private static func inOrder(_ node: TreeNode?) -> String {
            guard let node = node else { return " null"}
            var strings = [String]()
            strings.append(inOrder(node.left))
            strings.append(String(node.val))
            strings.append(inOrder(node.right))
            return strings.joined(separator: ",")
        }
        
        private static func preOrder(_ node: TreeNode?) -> String {
            guard let node = node else { return " null"}
            var strings = [String]()
            strings.append(String(node.val))
            strings.append(preOrder(node.left))
            strings.append(preOrder(node.right))
            return strings.joined(separator: ",")
        }
    }
}
