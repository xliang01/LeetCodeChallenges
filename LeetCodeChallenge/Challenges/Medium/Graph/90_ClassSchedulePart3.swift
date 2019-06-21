//
//  90_ClassSchedulePart3.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/20/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/*
 Input: [[100, 200], [200, 1300], [1000, 1250], [2000, 3200]]
 Output: 3
 Explanation:
     There're totally 4 courses, but you can take 3 courses at most:
     First, take the 1st course, it costs 100 days so you will finish it on the 100th day, and ready to take the next course on the 101st day.
     Second, take the 3rd course, it costs 1000 days so you will finish it on the 1100th day, and ready to take the next course on the 1101st day.
     Third, take the 2nd course, it costs 200 days so you will finish it on the 1300th day.
     The 4th course cannot be taken now, since you will finish it on the 3300th day, which exceeds the closed date.
 */

class ClassSchedulePart3: Runnable {
    func runTests() {
        
    }
    
    private class SolutionRecursiveMemoization {
        func scheduleCourse(_ courses: [[Int]]) -> Int {
            if courses.isEmpty { return 0 }
            if courses.count == 1 { return 1 }
            
            let coursesSorted = courses.sorted(by: { (c1, c2) -> Bool in
                return c1[1] < c2[1]
            })
            
            var mem = [[Int?]](repeating: [Int?](repeating: nil, count: coursesSorted[coursesSorted.count-1][1] + 1), count: courses.count)
            return schedule(0, coursesSorted, 0, &mem)
        }
        
        private func schedule(_ courseNumber:Int, _ courses: [[Int]], _ time: Int, _ mem: inout [[Int?]]) -> Int {
            if courseNumber >= courses.count { return 0 }
            
            if let count = mem[courseNumber][time] {
                return count
            }
            
            let course = courses[courseNumber]
            let newCourseTime = course[0] + time
            var maxTimeToTakeCourse = 0
            
            if newCourseTime <= course[1] {
                maxTimeToTakeCourse = 1 + schedule(courseNumber + 1, courses, newCourseTime, &mem)
            }
            let maxTimeWithoutTakingCourse = schedule(courseNumber + 1, courses, time, &mem)
            mem[courseNumber][time] = max(maxTimeToTakeCourse, maxTimeWithoutTakingCourse)
            
            return mem[courseNumber][time]!
        }
    }
    
    private class SolutionRecursive {
        func scheduleCourse(_ courses: [[Int]]) -> Int {
            if courses.isEmpty { return 0 }
            if courses.count == 1 { return 1 }
            let coursesSorted = courses.sorted(by: { (c1, c2) -> Bool in
                return c1[1] < c2[1]
            })
            
            return schedule(0, coursesSorted, 0)
        }
        
        private func schedule(_ courseNumber:Int, _ courses: [[Int]], _ time: Int) -> Int {
            if courseNumber >= courses.count { return 0 }
            let course = courses[courseNumber]
            
            var maxTimeToTakeCourse = 0
            let courseTime = course[0] + time
            
            if courseTime <= course[1] {
                maxTimeToTakeCourse = 1 + schedule(courseNumber + 1, courses, courseTime)
            }
            let maxTimeWithoutTakingCourse = schedule(courseNumber + 1, courses, time)
            return max(maxTimeToTakeCourse, maxTimeWithoutTakingCourse)
        }
        
    }
}
