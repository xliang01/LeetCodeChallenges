//
//  75_RangeSumBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RangeSumBST: Runnable {
    func runTests() {
        
    }
    
    private class Solution {
        func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
            var ans = 0
            dfs(root, L, R, &ans)
            return ans
        }
        
        func dfs(_ root: TreeNode?, _ L: Int, _ R: Int, _ ans: inout Int) {
            guard let root = root else {
                return
            }
            if root.val >= L && root.val <= R {
                ans += root.val
                dfs(root.left, L, R, &ans)
                dfs(root.right, L, R, &ans)
            }
            else if root.val < L {
                dfs(root.right, L, R, &ans)
            }
            else if root.val > R {
                dfs(root.left, L, R, &ans)
            }
        }
    }

    // Definition for a binary tree node.
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
}
