//
//  28_MaxStack.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 4/14/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

class MaxStackOO: Runnable {
    func runTests() {
        let stack = SolutionArray()
        stack.push(5)
        stack.push(1)
        stack.push(5)
        print(stack.top())
        print(stack.popMax())
        print(stack.top())
        print(stack.peekMax())
        print(stack.pop())
        print(stack.top())
        
        let list = SolutionDoubleLinkedList()
        list.push(5)
        list.push(1)
        list.push(6)
        print(list.top())
        print(list.top())
        print(list.peekMax())
        print(list.popMax())
        print(list.popMax())
        print(list.pop())
        print(list.top())
    }
    
    private class SolutionArray {
        
        private (set) var array: [Int]
        private (set) var maxArray: [Int]
        
        /** initialize your data structure here. */
        init() {
            array = [Int]()
            maxArray = [Int]()
        }
        
        func push(_ x: Int) {
            array.append(x)
            if maxArray.isEmpty {
                maxArray.append(x)
            }
            else {
                let max = peekMax()
                maxArray.append(max > x ? max : x)
            }
        }
        
        func pop() -> Int {
            _ = maxArray.popLast()
            return array.popLast()!
        }
        
        func top() -> Int {
            return array.last!
        }
        
        func peekMax() -> Int {
            return maxArray.last!
        }
        
        func popMax() -> Int {
            let max = peekMax()
            var buffer = [Int]()
            while top() != max {
                buffer.append(pop())
            }
            _ = pop()
            while !buffer.isEmpty {
                push(buffer.popLast()!)
            }
            return max
        }
    }
    
    private class SolutionDoubleLinkedList {
        var map = [Int: [Node]]()
        var doubleLinkedList = DoubleLinkedList()
        
        func push(_ x: Int) {
            let node = doubleLinkedList.add(x)
            if map[x] == nil {
                map[x] = [Node]()
            }
            map[x]!.append(node)
        }
        
        func pop() -> Int {
            let val = doubleLinkedList.pop()
            var array = map[val]!
            _ = array.popLast()
            
            if array.isEmpty {
                map.removeValue(forKey: val)
            }
            else {
                map[val] = array
            }
            
            return val
        }
        
        func top() -> Int {
            return doubleLinkedList.peek()
        }
        
        func peekMax() -> Int {
            return map.keys.sorted().last!
        }
        
        func popMax() -> Int {
            let max = peekMax()
            var array = map[max]!
            let node = array.popLast()!
            _ = doubleLinkedList.unlink(node: node)
            
            if array.isEmpty {
                map.removeValue(forKey: max)
            }
            else {
                map[max] = array
            }
            
            return max
        }
    }
    
    private class DoubleLinkedList {
        var head: Node
        var tail: Node
        
        init() {
            head = Node(0)
            tail = Node(0)
            head.next = tail
            tail.prev = head
        }
        
        func add(_ val: Int) -> Node {
            let node = Node(val)
            node.prev = tail.prev
            node.next = tail
            tail.prev!.next = node
            tail.prev = node
            return node
        }
        
        func pop() -> Int {
            return unlink(node: tail.prev!).val
        }
        
        func peek() -> Int {
            return tail.prev!.val
        }
        
        func unlink(node: Node) -> Node {
            node.prev?.next = node.next
            node.next?.prev = node.prev
            return node
        }
    }
    
    private class Node {
        let val: Int
        var next: Node? = nil
        var prev: Node? = nil
        
        init(_ val: Int) {
            self.val = val
        }
    }
}

