//
//  16_DeleteColumnsSorted.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 3/24/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class DeletedColumnSorted: Runnable {
    func runTests() {
        let solution1 = SolutionMatrixMeasure()
        print(solution1.minDeletionSize(["cba","daf","ghi"]))
        print(solution1.minDeletionSize(["a","b"]))
        print(solution1.minDeletionSize(["zyx","wvu","tsr"]))
    }
    
    private class SolutionMatrixMeasure {
        /**
            Solution:
         
            Iterate through all the characters in the string, and ensure each subsequent row at each column
            is greater than the previous row. If not, increment count and break.
         
            Performance:
         
            Time Complexity: O(NM) where N is the number of values, and M is the character count of strings.
            Space Complexity: O(1) since no data structures are used to store additional data.
         */
        func minDeletionSize(_ A: [String]) -> Int {
            guard A.count > 1 else {
                return 0
            }
            var count = 0
            for i in (0..<A.first!.count) {
                let column = A.first!.index(A.first!.startIndex, offsetBy: i)
                for row in (1..<A.count) {
                    if A[row][column] < A[row - 1][column] {
                        count += 1
                        break
                    }
                }
            }
            return count
        }
    }
}
