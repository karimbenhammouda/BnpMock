//
//  MovieTest.swift
//  BnpMockTests
//
//  Created by karim BEN HAMMOUDA on 20/06/2022.
//

import XCTest
@testable import BnpMock
import RxSwift

class MovieTest: XCTestCase {
    func testMovie() {
        let movie = Movie(adult: false, backdropPath: "/i2tcQ9nDJpdJELPA82eCd7Irasd.jpg", genreIds: [28,53,12], id: 831946, originalLanguage: "en", originalTitle: "Interceptor", overview: "A U.S. Army Captain uses her years of tactical training to save humanity from sixteen nuclear missiles launched at the U.S. as a violent attack threatens her remote missile interceptor station.", popularity: 2110.736, posterPath: "/cpWUtkcgRKeauhTyVMjYHxAutp4.jpg", releaseDate: "2022-05-26", title: "Interceptor", video: false, voteAverage: 6.4, voteCount: 243)

        XCTAssertEqual(false, movie.adult)
        XCTAssertEqual("/i2tcQ9nDJpdJELPA82eCd7Irasd.jpg", movie.backdropPath)
        XCTAssertEqual([28,53,12], movie.genreIds)
        XCTAssertEqual(831946, movie.id)
        XCTAssertEqual("en", movie.originalLanguage)
        XCTAssertEqual("Interceptor", movie.originalTitle)
        XCTAssertEqual("A U.S. Army Captain uses her years of tactical training to save humanity from sixteen nuclear missiles launched at the U.S. as a violent attack threatens her remote missile interceptor station.", movie.overview)
        XCTAssertEqual(2110.736, movie.popularity)
        XCTAssertEqual("/cpWUtkcgRKeauhTyVMjYHxAutp4.jpg", movie.posterPath)
        XCTAssertEqual("2022-05-26", movie.releaseDate)
        XCTAssertEqual("Interceptor", movie.title)
        XCTAssertEqual(false, movie.video)
        XCTAssertEqual(6.4, movie.voteAverage)
        XCTAssertEqual(243, movie.voteCount)
    }
}
