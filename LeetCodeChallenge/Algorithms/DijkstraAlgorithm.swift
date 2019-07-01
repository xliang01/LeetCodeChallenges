////
////  DijkstraAlgorithm.swift
////  LeetCodeChallenge
////
////  Created by Xiao Liang on 6/30/19.
////  Copyright © 2019 TrackVia, Inc. All rights reserved.
////
//
//import Foundation
//
//class DijkstraShortestPath: Runnable {
//    func runTests() {
//        
//    }
//    
//    private class Dikstra<T> where T: Hashable {
//        func getShortestPath(_ edges: [Edge], from start: Vertex) -> [Vertex: Int] {
//            var graph = Dikstra.createGraph(edges)
//            var parents = [Vertex: Vertex?]()
//            var distance = [Vertex: Int]()
//            var heap = Heap<(vertex: Vertex, weight: Int)> { (lhs, rhs) -> Bool in
//                return lhs.weight < rhs.weight
//            }
//            
//            // For all edges in the graph, insert the node and its distance. If the node is the starting vertex, its distance is 0.
//            for edge in edges {
//                let distance = edge.start == start ? 0 : Int.max
//                heap.insert((edge.start, distance))
//            }
//            
//            while !heap.isEmpty {
//                // 1. Get the vertex with the least distance.
//                let heapNode = heap.remove()!
//                // Extract the vertex from the heap node.
//                let vertexToExamine = heapNode.vertex
//                // 2. Assign the current weight to the popped vertex.
//                distance[vertexToExamine] = heapNode.weight
//                
//                // 3. For each edge in the vertex, ensure it's in the heap. This ensures it's valid to visit.
//                for edge in vertexToExamine.edges {
//                    // Get the neighbor for the edge.
//                    guard let neighbor = graph.getAdjacentVertex(for: edge, on: vertexToExamine) else { continue }
//                    // Get the neighbor from the heap.
//                    let neighborHeapNode = heap.nodes.first(where: { $0.vertex == neighbor })
//                    // Check if the neighbor is in the heap.
//                    if let neighborHeapNode = neighborHeapNode {
//                        // If the neighbor is in the heap, assign its parent.
//                        parents[neighborHeapNode.vertex] = vertexToExamine
//                        neighborHeapNode.weight =
//                    }
//                }
//            }
//            
//            return [:]
//        }
//        
//        // MARK: Data Structures
//        
//        struct Vertex: Hashable, Equatable {
//            var value: T
//            var edges: [Edge]
//            
//            static func == (rhs: Vertex, lhs: Vertex) -> Bool {
//                return rhs.value == lhs.value
//            }
//            
//            func hash(into hasher: inout Hasher) {
//                hasher.combine(value)
//            }
//        }
//        
//        struct Edge: Equatable {
//            var start: Vertex
//            var end: Vertex
//            var weight: Int
//            
//            static func == (rhs: Edge, lhs: Edge) -> Bool {
//                return
//                    lhs.start == rhs.start &&
//                    lhs.end == rhs.end &&
//                    lhs.weight == rhs.weight
//            }
//        }
//        
//        class Graph {
//            private (set) var vertices: [Vertex]
//            private (set) var graph: [Vertex: [Edge]]
//            
//            init(_ edges: [Edge]) {
//                vertices = []
//                graph = [:]
//                
//                for edge in edges {
//                    vertices.append(edge.start)
//                    graph[edge.start, default: []].append(edge)
//                }
//            }
//            
//            func getVertex(_ index: Int) -> Vertex? {
//                if index < 0 || index >= vertices.count { return nil }
//                return vertices[index]
//            }
//            
//            func getEdges(_ vertex: Vertex) -> [Edge] {
//                return graph[vertex] ?? []
//            }
//            
//            func getAdjacentVertex(for edge: Edge, on vertex: Vertex) -> Vertex? {
//                return vertex
//                    .edges
//                    .first { $0 == edge }?
//                    .end
//            }
//        }
//        
//        static func createGraph(_ edges: [Edge]) -> Graph {
//            return Graph(edges)
//        }
//    }
//}
