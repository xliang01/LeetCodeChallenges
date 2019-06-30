//
//  66_ReconstructItinerary.swift
//  LeetCodeChallenge
//
//  Created by Xiao Liang on 6/9/19.
//  Copyright © 2019 TrackVia, Inc. All rights reserved.
//

import Foundation

/**
     Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order.
     All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.
 
     Note:
 
     If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
     All airports are represented by three capital letters (IATA code).
     You may assume all tickets form at least one valid itinerary.
 
     Example 1:
 
         Input: [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
         Output: ["JFK", "MUC", "LHR", "SFO", "SJC"]
 
     Example 2:
 
         Input: [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
         Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
         Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"].
         But it is larger in lexical order.
 */
class ReconstructItinerary: Runnable {
    func runTests() {
        let solution1 = SolutionDFSMinHeap()
        let solution2 = SolutionStackMinHeap()
        print(solution1.findItinerary([["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]))
        print(solution2.findItinerary([["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]))
    }
    
    /**
        Solution: This is an implementation of the Hierholzers algorithm.
     
        We effectively collect all nodes in a hashmap, and it's edges in a min heap for each starting point in the hashmap.
        We pick a starting point, and traverse through the hashmap. When we reach a destination using that edge, we go
        to the node and attempt to traverse again.
     
        In our example above for ["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"], we end up with
        a hashmap like
     
        [
            "JFK" : ["ATL", "SFO"],
            "SFO" : ["ATL"],
            "ATL" : ["JFK", "SFO"]
        ]
     
        Notice each array for the key is SORTED in lexographical order. We don't have to sort, but a Min Heap is perfect
        for sorting this and returning the lexographical element.
     
        Then we traverse each airport starting at JFK. Each edge we hit, we must remove the edge from the hashmap to indicate
        it's been traversed. We keep going until all airports no longer have edges. At that point, we pop back to the original
        aiport, and keep popping up the stack.
     
        This is effectively a DFS because we just keep reaching until we can no longer traverse the edges. Instead of using a matrix,
        we use a hashmap and a minheap to indicate which nodes have been visited.
     
        Performance:
     
        Time Complexity: O(N) + O(E) = O(E) where N is the number of elements needed to create the hashmap, and E are the edges generated.
        Space Complexity: O(N) + O(2E) where N is the number of elements in the hashmap, E is the number of edges in the hashmap, and E is
        also the number of edges in the output.
    */
    private class SolutionDFSMinHeap {
        func findItinerary(_ tickets: [[String]]) -> [String] {
            var flights = [String: Heap<String>]()
            
            for ticket in tickets {
                if flights[ticket[0]] == nil {
                    flights[ticket[0]] = Heap<String>(sort: { $0 < $1 })
                }
                flights[ticket[0]]?.insert(ticket[1])
            }
            
            var routes: [String] = []
            dfs(&flights, "JFK", &routes)
            return routes.reversed()
        }
        
        func dfs(_ flights: inout [String: Heap<String>], _ airport: String, _ routes: inout [String]) {
            while flights[airport] != nil, !flights[airport]!.isEmpty {
                dfs(&flights, flights[airport]!.remove()!, &routes)
            }
            routes.append(airport)
        }
    }
    
    private class SolutionStackMinHeap {
        func findItinerary(_ tickets: [[String]]) -> [String] {
            var flights = [String: Heap<String>]()
            
            for ticket in tickets {
                if flights[ticket[0]] == nil {
                    flights[ticket[0]] = Heap<String>(sort: { $0 < $1 })
                }
                flights[ticket[0]]?.insert(ticket[1])
            }
            
            var routes: [String] = []
            var stack = ["JFK"]
            
            while !stack.isEmpty {
                while flights[stack.last!] != nil, !flights[stack.last!]!.isEmpty {
                    stack.append(flights[stack.last!]!.remove()!)
                }
                routes.append(stack.popLast()!)
            }
            
            return routes.reversed()
        }
    }
}
