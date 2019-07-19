//
//  PartitionLinkedList.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/18/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

private typealias Node = LinkedList<Int>.Node

class PartitionLinkedList: Runnable {
    func runTests() {
        let solution = SolutionBeforeAfter()
        
        let head = PartitionLinkedList.head
        PartitionLinkedList.printNode(head)
        
        let partition = solution.partition(head, 5)
        PartitionLinkedList.printNode(partition)
    }
    
    private static var head: Node? {
        var head: Node? = nil
        var curr: Node? = nil
        
        for i in (1...10).reversed() {
            if head == nil {
                head = Node(value: i)
                curr = head
            }
            else {
                curr?.next = Node(value: i)
                curr = curr?.next
            }
        }
        return head
    }
    
    private static func printNode(_ node: Node?) {
        var vals = [Int]()
        var node = node
        while node != nil {
            vals.append(node!.value)
            node = node!.next
        }
        let string = vals.map { "\($0)" }.joined(separator: ",")
        print(string)
    }
    
    private class SolutionBeforeAfter {
        func partition(_ head: Node?, _ x: Int) -> Node? {
            var node = head
            
            var smaller: Node? = nil
            var smallerCurr: Node? = nil
            var larger: Node? = nil
            var largerCurr: Node? = nil
            
            while node != nil {
                let val = node!.value
                let next = node?.next
                node?.next = nil
                
                if val < x {
                    if smaller == nil {
                        smaller = node
                        smallerCurr = smaller
                    }
                    else {
                        smallerCurr?.next = node
                        smallerCurr = smallerCurr?.next
                    }
                }
                else {
                    if larger == nil {
                        larger = node
                        largerCurr = larger
                    }
                    else {
                        largerCurr?.next = node
                        largerCurr = largerCurr?.next
                    }
                }
                node = next
            }
            smallerCurr?.next = larger
            return smaller
        }
        
        private func getTail(_ head: Node?) -> Node? {
            var temp = head
            // Get the tail
            while temp != nil {
                if temp?.next == nil {
                    return temp
                }
                temp = temp?.next
            }
            return nil
        }
    }
}
