//
//  40_MinimumMeetingRooms.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 5/12/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class MinimumMeetingRooms: Runnable {
    func runTests() {
        let solution1 = SolutionSortWithEndTimeCache()
        print(solution1.minMeetingRooms([]))
        print(solution1.minMeetingRooms([[1, 2]]))
        print(solution1.minMeetingRooms([[0, 30], [5, 10], [5, 15], [15, 20]]))
        print(solution1.minMeetingRooms([[7,10],[2,4]]))
        print(solution1.minMeetingRooms([[9,10],[4,9],[4,17]]))
        print(solution1.minMeetingRooms([[1,5],[8,9],[8,9]]))
    }
    
    private class SolutionSortWithEndTimeCache {
        /**
            Solution:
         
            Sort the time intervals in ascending order based on start time. The check if the current time at index 1
            is inside the time interval of the previous interval. If it is, this is a conflict of rooms, so a new room
            must be booked. Append the endtime of this interval into the time cache. If the start time is greater than
            or equal to a previously booked end time, then update that time to the current end time. Keep doing this
            until the entire array is marked. The total number of rooms is the number of end times in the time cache.
         
            Performance Analysis:
         
            Time Complexity: O(N^2). NLog(N) to sort the array. O(N^2) to loop through each time interval and also check
            if it already exists in the time cache.
         
            Space Complexity: O(N). O(N) for the sorted listed, and O(N) for the cache if all intervals are not allowed
            to share the same room.
         
            NOTE: Apparently instead of using an array, we can use a min heap. This allows us to always extra the min
            value in the array. This makes sense as if the start time is greater than the min value, then the new end
            time should be back in the min heap.
        */
        func minMeetingRooms(_ intervals: [[Int]]) -> Int {
            guard !intervals.isEmpty else { return 0 }
            let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
            var times = [sortedIntervals[0][1]]
            
            for i in (1..<intervals.count) {
                let startTime = sortedIntervals[i][0]
                let endTime = sortedIntervals[i][1]
                var override = false
                for (index, time) in times.enumerated() {
                    if startTime >= time {
                        times[index] = endTime
                        override = true
                        break
                    }
                }
                if !override {
                    times.append(endTime)
                }
            }
            
            return times.count
        }
        
        /*
         ///////////////////////////////////////////////////////
         Sorted [1,5] [8,9] [8,9]
         
         Stack
            9
            9
         
         ///////////////////////////////////////////////////////
         Sorted [1-10][2-5][5-12][10-15][11-13][13-15][15-16]
         
         Stack
            [1-10]->[10-15]->[15-16]
            [2-5]->[5-12]
            [11-13]->[13-15]
         
         Stack
            10 / 15
            5 / 12
            13 / 15
         
         ///////////////////////////////////////////////////////
         [9,10],[4,9],[4,17]
         Sorted [4, 9], [4, 17], [9, 10]
        
         Stack
            [4, 9] -> [9, 10]
            [4, 17]
         
         ///////////////////////////////////////////////////////
         [[0, 30],[5, 10],[15, 20]]
         Sorted [0, 30], [5, 10], [15, 20]
         
         Stack
            [5, 10] -> [15, 20]
            [0, 30]
         
         ///////////////////////////////////////////////////////
         [7,10],[2,4]
         Sorted [2, 4] [7, 10]
         
         Stack
            [2, 4]->[7,10]
        */
    }
}
