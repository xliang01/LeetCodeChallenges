//
//  MiddleOfLinkedList.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/22/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MiddleOfLinkedList: Runnable {
    func runTests() {
        
    }
    
    class SolutionSlowFastPointers {
        func middleNode(_ head: ListNode?) -> ListNode? {
            var slow = head
            var fast = head
            
            while fast != nil && fast?.next != nil {
                slow = slow?.next
                fast = fast?.next?.next
            }
            return slow
        }
    }
}
