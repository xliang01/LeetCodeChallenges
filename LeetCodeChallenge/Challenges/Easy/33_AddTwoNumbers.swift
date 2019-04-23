//
//  33_AddTwoNumbers.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/23/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AddTwoNumbers: Runnable {
    func runTests() {
        let solution = Solution()
        let sum = solution.addTwoNumbers(ListNode.l1, ListNode.l2)
        print(sum)
    }
    
    private class ListNode {
        var val: Int
        var next: ListNode?
        init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        static var l1: ListNode {
            let three = ListNode(3)
            let four = ListNode(4)
            let two = ListNode(2)
            four.next = three
            two.next = four
            return two
        }
        
        static var l2: ListNode {
            let five = ListNode(5)
            let six = ListNode(6)
            let four = ListNode(4)
            six.next = four
            five.next = six
            return five
        }
    }
    
    private class Solution {
        
        func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            var p1 = l1
            var p2 = l2
            var s: ListNode? = ListNode(-1)
            let head = s
            
            var carry = 0
            while p1 != nil || p2 != nil {
                let sum = (p1?.val ?? 0) + (p2?.val ?? 0) + carry
                carry = sum / 10
                p1 = p1?.next
                p2 = p2?.next
                s?.next = ListNode(sum % 10)
                s = s?.next
            }
            if carry > 0 {
                s?.next = ListNode(carry)
            }
            return head?.next
        }
    }
}
