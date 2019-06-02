//
//  55_TopK.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

public class TopK: Runnable {
    func runTests() {
        let solution1 = SolutionMinHeap()
        print(solution1.topKFrequent([1,1,1,2,2,3], 2))
        print(solution1.topKFrequent([1,2], 2))
        
        let solution2 = SolutionPriorityQueue()
        print(solution2.topKFrequent([1,1,1,2,2,3], 2))
        print(solution2.topKFrequent([1,2], 2))
        
        let solution3 = SolutionDictionarySort()
        print(solution3.topKFrequent([1,1,1,2,2,3], 2))
        print(solution3.topKFrequent([1,2], 2))
    }
    
    /**
        Solution:
     
        Create a frequency hash map that has the number as the key, and its occurences as the value. Then use a priority queue with
        a min heap functionality so the min number of ocurrences is always on the top. If more than k is inserted, remove it. This
        guarantees that the min is always removed when it hits k.
     
        Afterward, get all values from the priority queue (which will be appended in descending order), and finally reverse it because
        this will be the MAX values.
     
        Performance:
     
        Time Complexity: O(N) + N log(k) = N log(k). O(N) for creating the frequency hashmap. N Log(k) because we're always sorting by up to k for counts. Worst case is all numbers N are unique so we have a list count of 1.
        Space Complexity: O(N) + O(k) = O(N). O(N) for the hashmap and O(k) for the counts.
     */
    private class SolutionPriorityQueue {
        func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
            var frequency = [Int: Int]()
            for num in nums {
                if frequency[num] == nil { frequency[num] = 0 }
                frequency[num]! += 1
            }
            
            var priorityQueue = PriorityQueue<Int> { (l, r) -> Bool in
                return frequency[l]! < frequency[r]!
            }
            
            for num in frequency.keys {
                priorityQueue.enqueue(num)
                if priorityQueue.count > k {
                    _ = priorityQueue.dequeue()
                }
            }
            
            var counts = [Int]()
            while !priorityQueue.isEmpty {
                counts.append(priorityQueue.dequeue()!)
            }
            return counts.reversed()
        }
    }
    
    private class SolutionMinHeap {
        func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
            var frequency = [Int: Int]()
            for num in nums {
                if frequency[num] == nil { frequency[num] = 0 }
                frequency[num]! += 1
            }
            
            var counts = [Int: [Int]]()
            var minHeap = Heap<Int> { $0 < $1 }
            
            for (num, count) in frequency {
                if counts[count] == nil { counts[count] = [] }
                counts[count]!.append(num)
                minHeap.insert(count)
            }
            
            while minHeap.count > k {
                minHeap.remove()
            }
            
            var minCounts = [Int]()
            while !minHeap.isEmpty {
                minCounts.append(minHeap.remove()!)
            }
            return minCounts
                .reversed()
                .reduce([Int](), { values, count -> [Int] in
                    let response = values + [counts[count]![0]]
                    counts[count]!.remove(at: 0)
                    return response
                })
        }
    }
    
    private class SolutionDictionarySort {
        func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
            var countFor: [Int:Int] = [:]
            
            for num in nums {
                countFor[num] = (countFor[num] ?? 0) + 1
            }
            
            let sortedPairs = countFor.sorted{ $0.value > $1.value }
            let sortedNums = sortedPairs.map{ $0.key }
            return Array(sortedNums.prefix(k))
        }
    }
    
}
