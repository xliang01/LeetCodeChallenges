//
//  SameTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/4/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SameTree: Runnable {
    func runTests() {
        let solution = SolutionInOrder()
        print(solution.isSameTree(nil, nil))
    }
    // T: O(N)
    // S: O(Log(N)) or O(N). Worst case O(N) space if tree is not balanced.
    private class SolutionInOrder {
        func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
            return preOrder(p, q)
        }
        
        func preOrder(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
            if p == nil && q == nil { return true }
            else if (p != nil && q == nil) || (p == nil && q != nil) { return false }
            
            if let p = p, let q = q {
                if p.val != q.val { return false }
                else if !preOrder(p.left, q.left) || !preOrder(p.right, q.right) { return false }
            }
            return true
        }
    }
}
