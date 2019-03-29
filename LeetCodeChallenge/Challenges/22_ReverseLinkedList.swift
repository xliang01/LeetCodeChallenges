//
//  22_ReverseLinkedList.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/28/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class ReverseLinkedList: Runnable {
    func runTests() {
        let head1 = ListNode.getSample()
        let solution1 = SolutionIterativeReverseArray()
        let reverse1 = solution1.reverseList(head1)
        
        let head2 = ListNode.getSample()
        let solution2 = SolutionIterativeReverseThreePointer()
        let reverse2 = solution2.reverseList(head2)
        
        print(reverse2)
        
        let head3 = ListNode.getSample()
        let solution3 = SolutionIterativeReverseTwoPointers()
        let reverse3 = solution3.reverseList(head3)
        
        print(reverse3)
        
        let head4 = ListNode.getSample()
        let solution4 = SolutionIterativeRecursive()
        let reverse4 = solution4.reverseList(head4)
        
        print(reverse4)
    }
    /**
        * Definition for singly-linked list.
     */
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    
        static func getSample() -> ListNode {
            let n = 5
            let head = ListNode(1)
            var currentNode = head
            for i in (2...n) {
                let node = ListNode(i)
                currentNode.next = node
                currentNode = node
            }
            return head
        }
    }
    
    private class SolutionIterativeReverseArray {
        func reverseList(_ head: ListNode?) -> ListNode? {
            guard let head = head else {
                return nil
            }
            
            var nodes = [ListNode]()
            var currentNode: ListNode? = head
            
            while(currentNode != nil) {
                nodes.append(currentNode!)
                currentNode = currentNode!.next
            }
            
            for i in (1...nodes.count-1).reversed() {
                nodes[i].next = nodes[i-1]
                if i - 1 == 0 {
                    nodes[0].next = nil
                }
            }
            
            return nodes[nodes.count - 1]
        }
    }
    
    private class SolutionIterativeReverseThreePointer {
        /**
         Solution:
         
         We use three pointers to keep track of where to iterate in the list.
         
         1. Previous node.
         2. Current node, used to iterate through the array and assign "next" back to a previous node.
         3. The next node to move forward.
         
         We ensure the previous node starts at head, current node starts at next, and next node starts at next next.
         As we iterate through the list, we assign the current node's next to the previous node. Then the previous node
         becomes the current node. The current node becomes the next node assuming the next node is not nil. If the next
         node is nil, we know the list has ended.
         
         Performance:
         
         Time Complexity: O(N) to iterate through the linked list.
         Space Complexity: O(1) since we just have 3 pointer nodes.
         */
        func reverseList(_ head: ListNode?) -> ListNode? {
            var previousNode: ListNode? = head
            var currentNode: ListNode? = head?.next
            
            // If the current node is nil, just return head.
            if currentNode == nil {
                return previousNode
            }
            
            // While the curernt node is not nil, iterate through the linked list.
            while(currentNode != nil) {
                // Get the next node.
                let nextNode = currentNode?.next
                // If the previous node is the head, assign to nil because we are reversing the linked list, so the last element should have nil next reference.
                if previousNode === head {
                    previousNode?.next = nil
                }
                // Assign the next to the previous node.
                currentNode?.next = previousNode
                previousNode = currentNode
                // If the next node is nil, we know it's the end of the list so just return.
                if nextNode == nil {
                    break
                }
                currentNode = nextNode
            }
            
            return currentNode
        }
    }
        
    private class SolutionIterativeReverseTwoPointers {
        /**
             Solution:
         
             We use three pointers to keep track of where to iterate in the list.
         
             1. Previous node.
             2. Current node, used to iterate through the array and assign "next" back to a previous node.
             3. The next node to move forward.
         
             We ensure the previous node starts at head, current node starts at next, and next node starts at next next.
             As we iterate through the list, we assign the current node's next to the previous node. Then the previous node
             becomes the current node. The current node becomes the next node assuming the next node is not nil. If the next
             node is nil, we know the list has ended.
         
             Performance:
         
             Time Complexity: O(N) to iterate through the linked list.
             Space Complexity: O(1) since we just have 3 pointer nodes.
         */
        func reverseList(_ head: ListNode?) -> ListNode? {
            var previousNode: ListNode? = nil
            var currentNode: ListNode? = head
            
            // While the curernt node is not nil, iterate through the linked list.
            while(currentNode != nil) {
                // Get the next node.
                let nextNode = currentNode?.next
                currentNode?.next = previousNode
                previousNode = currentNode
                currentNode = nextNode
            }
            
            return previousNode
        }
    }
    
    private class SolutionIterativeRecursive {
        func reverseList(_ head: ListNode?) -> ListNode? {
            if head == nil || head?.next == nil {
                return head
            }
            let nextNode = reverseList(head?.next)
            head?.next?.next = head
            head?.next = nil
            
            return nextNode
        }
    }
}
