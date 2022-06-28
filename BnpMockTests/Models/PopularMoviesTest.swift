//
//  PopularMoviesTest.swift
//  BnpMockTests
//
//  Created by karim BEN HAMMOUDA on 20/06/2022.
//

import XCTest
@testable import BnpMock

class PopularMoviesTest: XCTestCase {
    func testMovie() {
        let popularMovies = PopularMovies(page: 1, results: [Movie(adult: false, backdropPath: "/i2tcQ9nDJpdJELPA82eCd7Irasd.jpg", genreIds: [28,53,12], id: 831946, originalLanguage: "en", originalTitle: "Interceptor", overview: "A U.S. Army Captain uses her years of tactical training to save humanity from sixteen nuclear missiles launched at the U.S. as a violent attack threatens her remote missile interceptor station.", popularity: 2110.736, posterPath: "/cpWUtkcgRKeauhTyVMjYHxAutp4.jpg", releaseDate: "2022-05-26", title: "Interceptor", video: false, voteAverage: 6.4, voteCount: 243)], totalPages: 33929, totalResults: 678569)
        
        XCTAssertEqual(1, popularMovies.page)
        XCTAssertEqual(false, popularMovies.results[0].adult)
        XCTAssertEqual("/i2tcQ9nDJpdJELPA82eCd7Irasd.jpg", popularMovies.results[0].backdropPath)
        XCTAssertEqual([28,53,12], popularMovies.results[0].genreIds)
        XCTAssertEqual(831946, popularMovies.results[0].id)
        XCTAssertEqual("en", popularMovies.results[0].originalLanguage)
        XCTAssertEqual("Interceptor", popularMovies.results[0].originalTitle)
        XCTAssertEqual("A U.S. Army Captain uses her years of tactical training to save humanity from sixteen nuclear missiles launched at the U.S. as a violent attack threatens her remote missile interceptor station.", popularMovies.results[0].overview)
        XCTAssertEqual(2110.736, popularMovies.results[0].popularity)
        XCTAssertEqual("/cpWUtkcgRKeauhTyVMjYHxAutp4.jpg", popularMovies.results[0].posterPath)
        XCTAssertEqual("2022-05-26", popularMovies.results[0].releaseDate)
        XCTAssertEqual("Interceptor", popularMovies.results[0].title)
        XCTAssertEqual(false, popularMovies.results[0].video)
        XCTAssertEqual(6.4, popularMovies.results[0].voteAverage)
        XCTAssertEqual(243, popularMovies.results[0].voteCount)
        XCTAssertEqual(33929, popularMovies.totalPages)
        XCTAssertEqual(678569, popularMovies.totalResults)
    }
}
