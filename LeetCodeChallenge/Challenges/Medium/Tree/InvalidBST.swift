//
//  InvalidBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class InvalidBST: Runnable {
    func runTests() {
        
    }
    
    private class SolutionDFS {
        func isValidBST(_ root: TreeNode?) -> Bool {
            return dfs(root, nil, nil)
        }
        
        private func dfs(_ root: TreeNode?, _ lower: Int?, _ upper: Int?) -> Bool {
            guard let root = root else { return true }
            let val = root.val
            
            if let lower = lower, val >= lower { return false }
            if let upper = upper, val <= upper { return false }
            
            return dfs(root.left, val, upper) && dfs(root.right, lower, val)
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
            strings.append(inOrder(node.left))
            strings.append(inOrder(node.right))
            return strings.joined(separator: ",")
        }
    }
}
