//
//  54_TaskScheduler.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/1/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class TaskScheduler: Runnable {
    func runTests() {
        let solution1 = SolutionLoop()
        print(solution1.leastInterval(["A", "B"], 2))
        print(solution1.leastInterval(["A","A","B","B"], 2))
        print(solution1.leastInterval(["A","A","A","B","B","B"], 2))
        print(solution1.leastInterval(["A","A","A","B","B","B","C","C"], 2))
        print(solution1.leastInterval(["A","A","A","A","A","A","B","C","D","E","F","G"], 2))
    }
    
    private class SolutionLoop {
        /**
            Solution:
         
            For the simple case where we have AAABB, with n = 2, the best execution we can run is
         
                A -> B -> Idle -> A -> B -> Idle -> A
         
            Notice that we always want to process the letter that has the MOST occurence. Why? Because we want to minimize idle
            time by maximizing the process for tasks. Tasks with the most occurence can execute more tasks in between. Otherwise,
            notice that if we started with B instead of A:
         
                B -> A -> Idle -> B -> A -> Idle -> Idle -> A
         
            Here, we had an additional idle time because A wasn't maximized. Knowing this, we can deduce that we must run A first
            in order to reduce idle time.
         
            So first, we determine the count of the letters by creating an Array that holds the count of the occurences of the letters.
            Since the letters can be represented in ASCII, we can convert it into an ASCII value and store it in an array. Now, each task
            can be sorted to ensure only tasks that have the most count is at the beginning. Tasks with 0 are skipped because they don't
            have any counts.
         
            To process the tasks, we continue to check if the first element in the taskCounts array is greater than 0. This is sort of
            a queue check to see if there's any more tasks left to process. Then from 0 to n (which is the processing cycle between tasks),
            we decrement taskCounts for each index at n. Think of this as using a CPU cycle to process a task.
         
            As we iterate through the taskCounts array, we know a task is still valid if it's count is greater than 0, and it's less than
            the max amount of task counts we can hold. Then we decrement the task count because it's now processed by a CPU. We then
            increase the CPU process count because one task has been executed.
         
            Finally, we sort the tasks to ensure only the tasks that still have a count > 0 are processed.
         
            Performance:
         
            Time Complexity: O(1) sort (because we only sort by 26 instead of N) + O(N) for iterating through all tasks to form the array.
            Space Complexity: O(1) because we're only generating an array of static 26 length. It is not variable by the input length.
         */
        func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
            var taskCounts = [Int](repeating: 0, count: 26)
            let offset = Character("A").asciiValue!
            tasks
                .map { Int($0.asciiValue! - offset) }
                .sorted()
                .forEach { taskCounts[$0] += 1 }
            
            taskCounts = taskCounts.sorted { $0 > $1 }
            var times = 0
            
            while taskCounts[0] > 0 {
                for slotToExecute in 0...n {
                    if taskCounts[0] == 0 {
                        break
                    }
                    if slotToExecute < taskCounts.count && taskCounts[slotToExecute] > 0 {
                        taskCounts[slotToExecute] -= 1
                    }
                    times += 1
                }
                taskCounts = taskCounts.sorted { $0 > $1 }
            }
            
            return times
        }
    }
    
    // Bottom doesn't work
    
    private class SolutionCounter {
        func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
            guard !tasks.isEmpty else { return 0 }
            
            var countOfTasks = Array(repeating: 0, count: 26)
            let offset = Character("A").asciiValue!
            for task in tasks {
                let count = Int(task.asciiValue! - offset)
                countOfTasks[count] += 1
            }
            
            var mostFrequency = 0
            var numOfMostFrequency = 0
            for count in countOfTasks {
                if count == mostFrequency {
                    numOfMostFrequency += 1
                }
                else if count > mostFrequency {
                    mostFrequency = count
                    numOfMostFrequency = 1
                }
            }
            
            return max((n+1) * (mostFrequency-1) + numOfMostFrequency, tasks.count)
        }
    }
}
