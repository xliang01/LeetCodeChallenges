//
//  ValidateBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/30/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoValidateBinaryTree: Runnable {
    func runTests() {
        let bst = BST()
        print(bst.validateBST(AlgoValidateBinaryTree.valid))
        print(bst.validateBST(AlgoValidateBinaryTree.invalid))
    }
    
    private class BST {
        func validateBST(_ node: TreeNode?) -> Bool {
            return validate(node, nil, nil)
        }
        
        private func validate(_ node: TreeNode?, _ lower: Int?, _ upper: Int?) -> Bool {
            guard let node = node else { return true }
            
            if let lower = lower, node.val > lower { return false }
            else if let upper = upper, node.val < upper { return false }
            
            let validateLeft = validate(node.left, node.val, upper)
            let validateRight = validate(node.right, lower, node.val)
            return validateLeft && validateRight
        }
    }
    
    private static var valid: TreeNode {
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
    
    private static var invalid: TreeNode {
        let four = TreeNode(4)
        let five = TreeNode(5)
        let seven = TreeNode(7)
        let eight = TreeNode(8)
        let nine = TreeNode(9)
        let ten = TreeNode(10)
        let eleven = TreeNode(11)
        
        eleven.right = ten
        eight.left = seven
        nine.left = eight
        nine.right = eleven
        five.left = four
        five.right = nine
        return five
    }
    
}
