//
//  InvertBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoInvertBST: Runnable {
    func runTests() {
        let invertedBST = InvertBST()
        
        print("Tree 1")
        var tree1: TreeNode! = AlgoInvertBST.tree1
        print("Before Invert: \(tree1.bfs)")
        invertedBST.invert(&tree1)
        print("After Invert: \(tree1.bfs)")
        
        print("Tree 2")
        var tree2: TreeNode! = AlgoInvertBST.tree2
        print("Before Invert: \(tree2.bfs)")
        invertedBST.invert(&tree2)
        print("After Invert: \(tree2.bfs)")
    }
    
    private class InvertBST {
        func invert(_ root: inout TreeNode?) {
            guard let root = root else { return }
            
            let temp = root.right
            root.right = root.left
            root.left = temp
            
            invert(&root.left)
            invert(&root.right)
        }
    }
    
    private static var tree1: TreeNode {
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
    
    private static var tree2: TreeNode {
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
