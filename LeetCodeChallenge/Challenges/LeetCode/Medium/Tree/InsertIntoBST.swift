//
//  InsertIntoBST.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class InsertIntoBST: Runnable {
    func runTests() {
        
    }
    
    private class SolutionDFS {
        func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
            guard let root = root else {
                return TreeNode(val)
            }
            
            if val > root.val {
                root.right = insertIntoBST(root.right, val)
            }
            else {
                root.left = insertIntoBST(root.left, val)
            }
            return root
        }
    }
}
