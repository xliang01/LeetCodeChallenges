//
//  82_MergeKSortedArrays.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/17/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MergeKSortedArrays: Runnable {
    func runTests() {
        let solution1 = SolutionPriorityQueue()
        print(solution1.mergeKLists([ListNode.l1, ListNode.l2, ListNode.l3])?.description)
        
        let solution2 = SolutionMergeArrays()
        print(solution2.mergeKLists([ListNode.l1, ListNode.l2, ListNode.l3])?.description)
    }
    
    private class SolutionPriorityQueue {
        func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
            guard !lists.isEmpty else { return nil }
            
            var queue = Heap<(ListNode)> { node1, node2 -> Bool in
                return node1.val < node2.val
            }
            
            for node in lists {
                if let node = node {
                    queue.insert(node)
                }
            }
            
            var currentNode: ListNode? = nil
            var headNode: ListNode? = nil
            
            while !queue.isEmpty {
                let node = queue.remove()!
                if currentNode == nil {
                    currentNode = node
                    headNode = currentNode
                }
                else {
                    currentNode?.next = node
                    currentNode = node
                }
                
                if let nextNode = node.next {
                    queue.insert(nextNode)
                }
            }
            return headNode
        }
    }
    
    private class SolutionMergeArrays {
        func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
            if lists.isEmpty { return nil }
            if lists[0] == nil { return nil }
            return mergeByTwo(lists)
        }
        
        private func mergeByTwo(_ lists: [ListNode?]) -> ListNode? {
            if lists.isEmpty { return nil }
            if lists.count == 1 { return lists[0] }
            var mergedLists = [ListNode?]()
            
            var i = 0
            while i < lists.count {
                let l1 = lists[i]
                var l2: ListNode?
                if i + 1 < lists.count {
                    l2 = lists[i + 1]
                }
                i += 2
                
                if i > lists.count {
                    mergedLists.append(l1)
                }
                else {
                    mergedLists.append(mergeList(l1, l2))
                }
            }
            
            return mergeByTwo(mergedLists)
        }
        
        private func mergeList(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            guard let node1 = l1, let node2 = l2 else { return l1 ?? l2 }
            
            var curr: ListNode? = ListNode(0)
            let head = curr
            
            var p1: ListNode? = node1
            var p2: ListNode? = node2
            
            while p1 != nil && p2 != nil {
                if p1!.val <= p2!.val {
                    curr?.next = p1
                    p1 = p1?.next
                }
                else {
                    curr?.next = p2
                    p2 = p2?.next
                }
                curr = curr?.next
            }
            
            if p1 == nil {
                curr?.next = p2
            }
            else if p2 == nil {
                curr?.next = p1
            }
            return head?.next
        }
    }
    
    // Definition for singly-linked list.
    private class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        static var l1: ListNode {
            let one = ListNode(1)
            let four = ListNode(4)
            let five = ListNode(5)
            four.next = five
            one.next = four
            return one
        }
        
        static var l2: ListNode {
            let one = ListNode(1)
            let three = ListNode(3)
            let four = ListNode(4)
            three.next = four
            one.next = three
            return one
        }
        
        static var l3: ListNode {
            let one = ListNode(2)
            let six = ListNode(6)
            one.next = six
            return one
        }
        
        var description: String {
            var string: String = ""
            var curr: ListNode? = self
            
            while curr != nil {
                string += "\(curr!.val)"
                if curr?.next != nil {
                    string += "->"
                }
                curr = curr?.next
            }
            
            return string
        }
    }
}
