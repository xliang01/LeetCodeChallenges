//
//  RemoveElements.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class RemoveElements: Runnable {
    func runTests() {
        
    }
    
    private class SolutionPointers {
        func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
            var prev: ListNode? = nil
            var curr: ListNode? = head
            var head = head
            
            while curr != nil {
                if let currVal = curr?.val, currVal == val {
                    if prev == nil {
                        head = head?.next
                        curr = head
                    }
                    else {
                        prev?.next = curr?.next
                        curr = curr?.next
                    }
                }
                else {
                    prev = curr
                    curr = curr?.next
                }
            }
            
            
            return head
        }
    }
}
