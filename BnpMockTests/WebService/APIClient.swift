//
//  APIClient.swift
//  BnpMockTests
//
//  Created by karim BEN HAMMOUDA on 20/06/2022.
//

import XCTest
@testable import BnpMock
import RxSwift

class APIClientTest: XCTestCase {
    func testResultsApi() {
        let sut = APIClient()
        let listMovies: Observable<PopularMovies>? = sut.getData(url: APIRoute.getListMovies.urlString)
        let disposeBag = DisposeBag()
        listMovies?
            .debug("mainListMovies received event")
            .subscribe(onNext: { movieListResult in
                XCTAssertTrue(movieListResult.results.count > 1, "listes des produits not vide")
        }).disposed(by: disposeBag)
    }
    
    func testResultsMock() {
        let sut = APIClientMock()
        let listMovies: Observable<PopularMovies>? = sut.getData(url: APIRoute.getListMoviesMock.urlString)
        let disposeBag = DisposeBag()
        listMovies?
            .debug("mainListMovies received event")
            .subscribe(onNext: { movieListResult in
                XCTAssertTrue(movieListResult.results.count > 1, "listes des produits not vide")
        }).disposed(by: disposeBag)
    }
    
    func testMockFile() {
        let path = Bundle.main.path(forResource: APIRoute.getListMoviesMock.urlString, ofType: "json")
        XCTAssertNotNil(path)
    }
    
    func testResultsPath() {
        let sut = APIClientMock()
        let listMovies = sut.getmMockData(name: APIRoute.getListMoviesMock.urlString)
        XCTAssertNotNil(listMovies)
    }
}
