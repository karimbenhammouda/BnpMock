//
//  MovieTableViewCell.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moviePhoto: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    // MARK: - Properties
    
    var viewModel: MovieCellViewModel!
    
    // MARK: - override func
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - public func
    
    func setup() {
        movieDescription.text = viewModel.movie.overview
        DispatchQueue.main.async {
            self.movieDescription.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: Constants.font.readMoreFont, moreTextColor: .black)
        }
        movieTitle.text = viewModel.movie.originalTitle
        moviePhoto.loadImageAsync(with: "\(APIRoute.getImage.urlString)\(viewModel.movie.posterPath)")
    }
    
}
