//
//  ViewController.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import UIKit

class ViewController: UIViewController {
    let homePageView: HomePageCollectionView = {
        let view = HomePageCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHomePageView()
        
    }
    
    func setupHomePageView() {
        view.addSubview(homePageView)
        NSLayoutConstraint.activate([
            homePageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homePageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homePageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

