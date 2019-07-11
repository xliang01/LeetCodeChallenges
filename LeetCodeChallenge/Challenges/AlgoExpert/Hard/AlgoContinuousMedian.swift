//
//  AlgoContinuousMedian.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/7/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class AlgoContinuousMedianHandler: Runnable {
    func runTests() {
        let solution = ContinuousMedianHandlerHeap()
        solution.insert(5)
        solution.insert(10)
        print(solution.getMedian())
        solution.insert(100)
        solution.insert(101)
        solution.insert(20)
        print(solution.getMedian())
    }
    
    private class ContinuousMedianHandlerHeap {
        var maxHeapLeft = Heap<Int> { $0 > $1 }
        var minHeapRight = Heap<Int> { $0 < $1 }
        var median = 0.0
        var count = 0
        
        func insert(_ number: Int) {
            count += 1
            add(number)
            rebalance()
            calcMedian()
        }
    
        var isEven: Bool {
            return count % 2 == 0
        }
        
        func add(_ number: Int) {
            if let maxNumber = maxHeapLeft.peek() {
                if number > maxNumber {
                    minHeapRight.insert(number)
                }
                else {
                    maxHeapLeft.insert(number)
                }
            }
            else {
                maxHeapLeft.insert(number)
            }
        }
        
        func rebalance() {
            if maxHeapLeft.count > minHeapRight.count + 1 {
                minHeapRight.insert(maxHeapLeft.remove()!)
            }
            else if minHeapRight.count > maxHeapLeft.count + 1 {
                maxHeapLeft.insert(minHeapRight.remove()!)
            }
        }
        
        func calcMedian() {
            if !isEven {
                median = Double(minHeapRight.peek() ?? 0)
            }
            else {
                median = (Double(maxHeapLeft.peek() ?? 0) + Double(minHeapRight.peek() ?? 0))/2.0
            }
        }
        
        func getMedian() -> Double {
            return median
        }
    }
    
    private class ContinuousMedianHandlerLinkedList {
        var linkedList = LinkedList<Int>()
        var median: Double = 0
        var count = 0
        
        func insert(_ number: Int) {
            count += 1
            
            let isEven = count % 2 == 0
            linkedList.append(number)
            
            if count > 1 && !isEven { linkedList.remove(at: 0) }
            guard let head = linkedList.head else { return }
            
            if isEven {
                guard let next = head.next else { return }
                median = Double(head.value + next.value) / 2.0
            }
            else {
                median = Double(head.value)
            }
        }
        
        func getMedian() -> Double {
            return median
        }
    }
    
    private class ContinuousMedianHandlerArray {
        var median: Double = 0
        var array = [Int]()
        var count = 0
        
        func insert(_ number: Int) {
            array.append(number)
            let mid = (array.count - 1)/2
            
            if array.count % 2 != 0 {
                median = Double(array[mid])
            }
            else {
                median = Double(array[mid] + array[mid + 1])/2.0
            }
        }
        
        func getMedian() -> Double {
            return median
        }
    }
}
