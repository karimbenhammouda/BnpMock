//
//  ListMoviesTest.swift
//  BnpMockTests
//
//  Created by karim BEN HAMMOUDA on 20/06/2022.
//

import XCTest
@testable import BnpMock
import RxSwift
import Swinject

class ListMoviesTest: XCTestCase {
    private var sut: ListMoviesViewController!
    private var dataSource = TableViewDataSource()
    private var delegate = TableViewDelegate()
    private var viewModel: ListMoviesViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
      super.setUp()
        let swinjectContainer = SwinjectContainer()
        swinjectContainer.register()
        let coordinator = Coordinator(windowScene: nil, swinjectContainer: swinjectContainer, window: nil)
        let container = coordinator.container
        
        guard let listMoviesViewController = container.resolve(ListMoviesViewController.self, arguments: coordinator, "apiUrl") else {
            return
        }
        sut = listMoviesViewController
        sut.loadViewIfNeeded()
        sut.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier.movieCell)
        dataSource = TableViewDataSource()
        delegate = TableViewDelegate()
        sut.tableView.delegate = delegate
        sut.tableView.dataSource = dataSource
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testTableView() {
        let tableView = sut.tableView
        // Reload data
        tableView?.reloadData()
        let indexPath0 = IndexPath(item: 0, section: 0)
        let cell0 = tableView!.cellForRow(at: indexPath0)
        let visibleRows = tableView?.indexPathsForVisibleRows
        XCTAssert(visibleRows != nil)
        XCTAssertTrue(((tableView?.indexPathsForVisibleRows!.contains(indexPath0)) != nil))
        XCTAssert(cell0 != nil)
    }
}

private class TableViewDataSource: NSObject, UITableViewDataSource {
    var items = [Movie(adult: true, backdropPath:"", genreIds: [1], id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 2, posterPath: "", releaseDate: "", title: "", video: true, voteAverage: 2, voteCount: 1)]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier.movieCell, for: indexPath) as! MovieTableViewCell
        return cell
    }
    
    override init() {
        super.init()
    }
}

private class TableViewDelegate: NSObject, UITableViewDelegate {}

extension XCTestCase {
    func dataFrom(filename: String) -> Data {
        let path = Bundle(for: BnpMockTests.self).path(forResource: filename, ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
}
