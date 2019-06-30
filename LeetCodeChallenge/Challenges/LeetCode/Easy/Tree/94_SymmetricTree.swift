//
//  94_SymmetricTree.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/21/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class SymmetricTree: Runnable {
    func runTests() {
        let solution = SolutionDFS()
        print(solution.isSymmetric(TreeNode.root))
    }
    
    /**
        Time Complexity: O(N) because very node must be visited.
        Space Complexity: O(N) if the tree is unbalanced and on one side.
    */
    private class SolutionDFS {
        func isSymmetric(_ root: TreeNode?) -> Bool {
            return isSymmetric(root, root)
        }
        
        private func isSymmetric(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
            if root1 == nil && root2 == nil {
                return true
            }
            else if root1?.val != root2!.val {
                return false
            }
            return
                isSymmetric(root1?.left, root2?.right) &&
                isSymmetric(root1?.right, root2?.left)
        }
    }
    
    /**
        Time Complexity: O(N) because very node must be visited.
        Space Complexity: O(N) to traverse every node until the entire tree is visited.
     */
    private class SolutionBFS {
        func isSymmetric(_ root: TreeNode?) -> Bool {
            guard let root = root else { return true }
            if root.left?.val != root.right?.val { return false }
            
            var q = [TreeNode?]()
            q.append(root)
            q.append(root)
            
            while !q.isEmpty {
                let t1 = q.removeFirst()
                let t2 = q.removeFirst()
                
                if t1 == nil && t2 == nil { continue }
                else if t1 == nil || t2 == nil { return false }
                else if t1!.val != t2!.val { return false }
                
                q.append(t1?.left)
                q.append(t2?.right)
                q.append(t1?.right)
                q.append(t2?.left)
            }
            return true
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
            let leftTwo = two
            let rightTwo = two
            
            leftTwo.right = three
            rightTwo.left = three
            
            one.left = leftTwo
            one.right = rightTwo
            
            return one
        }
        
        static var one: TreeNode {
            return TreeNode(1)
        }
        
        static var two: TreeNode {
            return TreeNode(2)
        }
        
        static var three: TreeNode {
            return TreeNode(3)
        }
    }
}
