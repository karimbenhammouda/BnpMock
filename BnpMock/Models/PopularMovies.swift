//
//  PopularMovies.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

public struct PopularMovies: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
