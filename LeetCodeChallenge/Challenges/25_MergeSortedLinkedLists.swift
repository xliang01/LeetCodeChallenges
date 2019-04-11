//
//  25_MergeSortedLinkedLists.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MergeSortedLinkedLists: Runnable {
    func runTests() {
        let solution1 = SolutionIterative()
        let mergedList1 = solution1.mergeTwoLists(ListNode.list1, ListNode.list2)
        print(mergedList1)
        
//        let mergedList2 = solution1.mergeTwoLists(ListNode.list3, ListNode.list4)
//        print(mergedList2)
//
//        let mergedList3 = solution1.mergeTwoLists(ListNode.list5, ListNode.list1)
//        print(mergedList3)
    }
    
    private class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        static var list1: ListNode {
            let one = ListNode(1)
            let two = ListNode(2)
            let four = ListNode(4)
            
            two.next = four
            one.next = two
            return one
        }
        
        static var list2: ListNode {
            let one = ListNode(1)
            let three = ListNode(3)
            let four = ListNode(4)
            
            three.next = four
            one.next = three
            return one
        }
        
        static var list3: ListNode {
            return ListNode(2)
        }
        
        static var list4: ListNode {
            return ListNode(1)
        }
        
        static var list5: ListNode {
            return ListNode(5)
        }
    }
    
    private class SolutionRecursive {
        func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            if l1 == nil {
                return l2
            }
            else if l2 == nil {
                return l1
            }
            else if let l1 = l1, let l2 = l2 {
                if l1.val < l2.val {
                    l1.next = mergeTwoLists(l1.next, l2)
                    return l1
                }
                else {
                    l2.next = mergeTwoLists(l1, l2.next)
                    return l2
                }
            }
            return nil
        }
    }
    
    private class SolutionIterative {
        func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            var l1 = l1
            var l2 = l2
            
            let head = ListNode(-1)
            var prev: ListNode? = head
            
            while let node1 = l1, let node2 = l2 {
                if node1.val < node2.val {
                    prev?.next = l1
                    l1 = node1.next
                }
                else {
                    prev?.next = l2
                    l2 = node2.next
                }
                prev = prev?.next
            }
            
            prev?.next = l1 ?? l2
            return head.next
        }
    }
}
