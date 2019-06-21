//
//  39_MergeIntervals.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MergeIntervals: Runnable {
    func runTests() {
        let solution1 = SolutionSort()
        print(solution1.merge([[2,3],[4,5],[6,7],[8,9],[1,10]]))
        print(solution1.merge([[1,3], [2,6], [8,10], [15,18]]))
        print(solution1.merge([[1,4],[4,5]]))
        print(solution1.merge([[1,4],[5,6]]))
    }
    
    private class SolutionSort {
        /**
            Solution:
         
            For this solution to work, one strategy is to sort the intervals list by the first element. This way,
            we can guarantee that the next element is either within the range, or outside of the range. For example,
         
            [2,3] -> [4,5] -> [6,7] -> [8,9] -> [1,10]
         
                Sorted
         
            [1,10] -> [2,3] -> [4,5] -> [6,7] -> [8,9]
         
            With this data structure, we know that every interval after the previous is either within the range, or
            not within the range. A better example is
         
            [0, 3] -> [0, 2] -> [0, 1] -> [1, 3] -> [2, 5] -> [3, 7] -> [8, 10]
         
            Here we can assume that if interval[0] is greater than the last interval[1], then this is possibly a new
            interval range by itself. Or it could be the new interval for the next set of merges. We add this on to the
            stack.
         
            If the interval[0] is less than the previous interval[1], the only thing to consider is determining which
            numbers are bigger. If the current interval[1] is bigger than the previous interval[1], then we update the
            last interval on the stack to be the biggest value. Otherwise, we leave the last stack alone and proceed
            forward to the next internval.
         
            Performance Analysis:
         
            Time Complexity: O(nlogn) for the sorting. Afterward, it's just O(N).
            Space Complexity: O(N) for the data struture, or O(1) if sort can be done in place.
         */
        func merge(_ intervals: [[Int]]) -> [[Int]] {
            let orderedIntervals = intervals.sorted { $0[0] < $1[0] }
            var answers = [[Int]]()
            
            for interval in orderedIntervals {
                if var last = answers.last {
                    if interval[0] > last[1] {
                        answers.append(interval)
                    }
                    else if interval[1] > last[1] {
                        answers[answers.count - 1][1] = interval[1]
                    }
                }
                else {
                    answers.append(interval)
                }
            }
            
            return answers
        }
    }
    
    // MARK: These past solutions were attempts and they don't work.
    
    private class SolutionBackScan {
        func merge(_ intervals: [[Int]]) -> [[Int]] {
            guard intervals.count > 0 else { return [] }
            let n = intervals.count
            var answer = intervals[n - 1]
            guard intervals.count > 1 else { return [answer] }
            
            var answers = [[Int]]()
            for i in (0..<n - 1).reversed() {
                let min = intervals[i][0]
                let max = intervals[i][1]
                
                if !(min > answer[0] && max < answer[1]) {
                    if min <= answer[0] && max >= answer[0] { answer[0] = min }
                    else if max < answer[0] {
                        answers.insert(answer, at: 0)
                        answer = [min, max]
                    }
                }
                
                if i == 0 { answers.insert(answer, at: 0) }
            }
            
            return answers
        }
    }
    
    private class SolutionScanWithCache {
        func merge(_ intervals: [[Int]]) -> [[Int]] {
            let n = intervals.count
            var cache = Set<Int>()
            var answers = [[Int]]()
            
            guard !intervals.isEmpty else { return [] }
            guard intervals.count > 1 else { return [intervals[0]] }
            
            for i in (0..<n) {
                if cache.contains(i) { continue }
                var min = intervals[i][0]
                var max = intervals[i][1]
                var hasCached = false
                
                for j in (i + 1..<n) {
                    let interval = intervals[j]
                    var hasChanged = false
                    if interval[0] >= min && interval[1] <= max {
                        hasChanged = true
                    }
                    else if interval[0] <= min && interval[1] >= max {
                        min = interval[0]
                        max = interval[1]
                        hasChanged = true
                    }
                    else if interval[0] >= min && interval[0] <= max && interval[1] >= max {
                        max = interval[1]
                        hasChanged = true
                    }
                    else if interval[0] < min && interval[1] <= max && interval[1] >= min {
                        min = interval[0]
                        hasChanged = true
                    }
                    
                    if hasChanged {
                        hasCached = hasChanged
                        cache.insert(j)
                    }
                    if j == n - 1 {
                        answers.append(interval)
                    }
                }
                
                if hasCached {
                    answers.append([min, max])
                }
            }
            return answers
        }
    }
}
