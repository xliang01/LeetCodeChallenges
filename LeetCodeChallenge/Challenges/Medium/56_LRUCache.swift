//
//  56_LRUCache.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/2/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class LRUCache: Runnable {
    func runTests() {
        let cache1 = LRUCacheWithLinkedList(2)
        cache1.put(1, 1)
        cache1.put(2, 2)
        print(cache1.get(1))       // returns 1
        cache1.put(3, 3)           // evicts key 2
        print(cache1.get(2))       // returns -1 (not found)
        cache1.put(4, 4)           // evicts key 1
        print(cache1.get(1))       // returns -1 (not found)
        print(cache1.get(3))       // returns 3
        print(cache1.get(4))       // returns 4

        print("New Cache")
        let cache2 = LRUCacheWithLinkedList(2)
        print(cache2.get(2))       // returns -1
        cache2.put(2, 6)
        print(cache2.get(1))       // returns -1
        cache2.put(1, 5)
        cache2.put(1, 2)           // Does not evict 2
        print(cache2.get(1))       // returns 2
        print(cache2.get(2))       // returns 6

        print("New Cache")
        let cache3 = LRUCacheWithLinkedList(2)
        cache3.put(1, 1)
        cache3.put(2, 2)
        print(cache3.get(1))    // returns 1
        cache3.put(3, 3)        // evicts 2
        print(cache3.get(2))    // returns -1
        cache3.put(4, 4)        // evicts 1
        print(cache3.get(1))    // returns -1
        print(cache3.get(3))    // returns 3
        print(cache3.get(4))    // returns 4
    }
    
    private class LRUCacheWithPriorityQueue {
        var capacity: Int
        var cache: [Int: Int] = [:]
        var priorities: [Int: Int] = [:]
        lazy var priorityQueue = PriorityQueue<Int> { (key1, key2) -> Bool in
            if
                let p1 = self.priorities[key1],
                let p2 = self.priorities[key2] {
                return p1 < p2
            }
            return true
        }
        
        init(_ capacity: Int) {
            self.capacity = capacity
        }
        
        func get(_ key: Int) -> Int {
            decreasePriorities()
            
            let val = cache[key]
            if val != nil { resetPriority(key) }
            return val ?? -1
        }
        
        func put(_ key: Int, _ value: Int) {
            decreasePriorities()
            cache[key] = value
            
            if priorityQueue.count == capacity {
                if priorities[key] != nil {
                    resetPriority(key)
                    return
                }
                else if let leastUsedKey = priorityQueue.dequeue() {
                    cache.removeValue(forKey: leastUsedKey)
                    priorities.removeValue(forKey: leastUsedKey)
                }
            }
            priorities[key] = 0
            priorityQueue.enqueue(key)
        }
        
        private func decreasePriorities() {
            priorities
                .keys
                .forEach {
                    priorities[$0]! -= 1
                    updatePriorityQueue($0)
                }
        }
        
        private func resetPriority(_ key: Int) {
            priorities[key] = 0
            updatePriorityQueue(key)
        }
        
        private func updatePriorityQueue(_ key: Int) {
            if let index = priorityQueue.index(of: key) {
                priorityQueue.changePriority(index: index, value: key)
            }
        }
    }
    
    private class LRUCacheWithLinkedList {
        var capacity: Int
        var cache = [Int : LRUNode]()
        var head: LRUNode
        var tail: LRUNode
        
        init(_ capacity: Int) {
            self.capacity = capacity
            self.head = LRUNode()
            self.tail = LRUNode()
            head.next = tail
            tail.previous = head
        }
        
        func get(_ key: Int) -> Int {
            if
                let node = cache[key],
                let value = node.value {
                moveTohead(node)
                return value
            }
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            if
                let node = cache[key] {
                node.value = value
                moveTohead(node)
            }
            else {
                let node = LRUNode(key: key,
                                   value: value)
                cache[key] = node
                moveTohead(node)
                
                if cache.count > capacity {
                    popTail()
                }
            }
        }
        
        // MARK: Private Methods
        
        private func insertNode(_ node: LRUNode) {
            node.previous = head
            node.next = head.next
            head.next?.previous = node
            head.next = node
        }
        
        private func removeNode(_ node: LRUNode) {
            node.previous?.next = node.next
            node.next?.previous = node.previous
        }
        
        private func moveTohead(_ node: LRUNode) {
            removeNode(node)
            insertNode(node)
        }
        
        private func popTail() {
            if let previous = tail.previous, let key = previous.key {
                removeNode(previous)
                cache.removeValue(forKey: key)
            }
        }
    }
    
    private class LRUNode {
        var key: Int?
        var value: Int?
        var next: LRUNode?
        weak var previous: LRUNode?
        
        init(key: Int? = nil,
             value: Int? = nil) {
            self.key = key
            self.value = value
        }
    }
}

