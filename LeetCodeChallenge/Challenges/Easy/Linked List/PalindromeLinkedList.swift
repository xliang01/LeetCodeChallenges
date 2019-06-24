//
//  PalindromeLinkedList.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class PalindromeLinkedList: Runnable {
    func runTests() {
        let solution = SolutionReverseLinkedList()
        print(solution.isPalindrome(ListNode.head))
    }
    
    private class SolutionReverseLinkedList {
        func isPalindrome(_ head: ListNode?) -> Bool {
            if head == nil { return true }
            
            var cur = head
            var curCopy: ListNode? = ListNode(cur!.val)
            let head = cur
            
            while cur?.next != nil {
                cur = cur?.next
                let nextCopy = ListNode(cur!.val)
                nextCopy.next = curCopy
                curCopy = nextCopy
            }
            
            cur = head
            while cur != nil {
                if cur?.val != curCopy?.val { return false }
                cur = cur?.next
                curCopy = curCopy?.next
            }
            
            return true
        }
    }
    
    // Definition for singly-linked list.
    private  class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        static var head: ListNode {
            let l1 = ListNode(1)
            let l2 = ListNode(2)
            let l3 = ListNode(3)
            let l4 = ListNode(2)
            let l5 = ListNode(1)
            
            l4.next = l5
            l3.next = l4
            l2.next = l3
            l1.next = l2
            
            return l1
        }
    }
}
