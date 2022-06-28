//
//  ListMoviesViewController.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import UIKit
import RxSwift
import RxCocoa


class ListMoviesViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ListMoviesViewModel!
    var coordinator: Coordinator
    private let disposeBag = DisposeBag()
    
    init(viewModel: ListMoviesViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - private func
    
    private func setupView() {
        title = "Movies"
        viewModel?.fetchMovieList()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: Constants.nibName.movieCell, bundle: nil), forCellReuseIdentifier: Constants.nibName.movieCell)
        bindTableView()
    }
    
    private func bindTableView() {
        viewModel?.displayedMovieList.map({ $0 })
            .debug("displayedMovieList received event")
            .bind(to: tableView.rx.items(cellIdentifier: Constants.nibName.movieCell, cellType: MovieTableViewCell.self)) { row, movie, cell in
                cell.viewModel = self.coordinator.container.resolve(MovieCellViewModel.self, argument: movie)
                cell.setup()
                
        }.disposed(by: disposeBag)
            
        tableView.rx.modelSelected(Movie.self).subscribe(onNext: { item in
           self.coordinator.showDetailsMovie(movie: item)
        }).disposed(by: disposeBag)
        
        self.setupTapSearch()
    }
    
    private func setupTapSearch() {
        self.searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { query in
                self.viewModel?.search(query)
                self.tableView.reloadData()
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}

// MARK: - extension UITableViewDelegate

extension ListMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
