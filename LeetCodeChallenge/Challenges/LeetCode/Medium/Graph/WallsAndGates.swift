//
//  WallsAndGates.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 7/11/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

class WallsAndGates: Runnable {
    func runTests() {
        let solution = SolutionBFS2()
        var rooms = [
            [2147483647,-1,0,2147483647],
            [2147483647,2147483647,2147483647,-1],
            [2147483647,-1,2147483647,-1],
            [0,-1,2147483647,2147483647]
        ]
        solution.wallsAndGates(&rooms)
        for r in rooms {
            print(r)
        }
    }
    
    private class SolutionBFS2 {
        func wallsAndGates(_ rooms: inout [[Int]]) {
            if rooms.isEmpty { return }
            
            let directions = [
                [0, -1],
                [0, 1],
                [-1, 0],
                [1, 0]
            ]
            
            var queue = [(row: Int, col: Int)]()
            for row in 0..<rooms.count {
                for col in 0..<rooms[0].count {
                    if rooms[row][col] == 0 {
                        queue.append((row: row, col: col))
                    }
                }
            }
            
            while !queue.isEmpty {
                let (row, col) = queue.removeFirst()
                for dir in directions {
                    let r = row + dir[0]
                    let c = col + dir[1]
                    if r < 0 || c < 0 || r >= rooms.count || c >= rooms[0].count || rooms[r][c] != Int32.max { continue }
                    rooms[r][c] = rooms[row][col] + 1
                    queue.append((row: r, col: c))
                }
            }
        }
    }
    
    private class SolutionBFS {
        func wallsAndGates(_ rooms: inout [[Int]]) {
            for row in 0..<rooms.count {
                for col in 0..<rooms[0].count {
                    if rooms[row][col] == 0 {
                        bfs(&rooms, row, col)
                    }
                }
            }
        }
        
        private func bfs(_ rooms: inout [[Int]],
                         _ row: Int,
                         _ col: Int) {
            var visited = [[Bool]](repeating: [Bool](repeating: false, count: rooms[0].count), count: rooms.count)
            var queue = [(row: Int, col: Int, dist: Int)]()
            queue.append((row: row, col: col, dist: 0))
            
            while !queue.isEmpty {
                let (row, col, dist) = queue.removeFirst()
                
                if
                    row < 0 ||
                    row >= rooms.count ||
                    col < 0 ||
                    col >= rooms[0].count ||
                    visited[row][col] ||
                    rooms[row][col] == -1 {
                    continue
                }
                
                let roomVal = rooms[row][col]
                
                if roomVal == 0 || roomVal == Int32.max || dist < roomVal  {
                    rooms[row][col] = min(dist, roomVal)
                    let newDist = dist + 1
                    queue.append((row: row-1, col: col, dist: newDist))
                    queue.append((row: row+1, col: col, dist: newDist))
                    queue.append((row: row, col: col-1, dist: newDist))
                    queue.append((row: row, col: col+1, dist: newDist))
                }
                
                visited[row][col] = true
            }
        }
    }
}
