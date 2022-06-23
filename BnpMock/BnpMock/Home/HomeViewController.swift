//
//  HomeViewController.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 14/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    
    // MARK: - @IBOutlet

    @IBOutlet weak var switchMock: UISwitch!
    
    // MARK: - override func
    
    override func viewDidLoad() {
        switchMock.setOn(false, animated: false)
    }
    
    // MARK: - @IBAction

    @IBAction func displayMoviesTapped(_ sender: Any) {
        viewModel?.coordinator?.showListMovies(isMock: switchMock.isOn)
    }
}
