//
//  DetailsMoviesViewController.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import UIKit

class DetailsMoviesViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moviePhoto: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: DetailsMoviesViewModel!
    
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
        title = viewModel.movie.originalTitle
        titleLabel.text = viewModel.movie.originalTitle
        descriptionLabel.text = viewModel.movie.overview
        moviePhoto.loadImageAsync(with: "\(APIRoute.getImage.urlString)\(viewModel.movie.backdropPath)")
    }
}
