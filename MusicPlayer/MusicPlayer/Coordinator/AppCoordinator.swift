//
//  AppCoordinator.swift
//  MovieList
//
//  Created by Vijay on 07/07/20.
//  Copyright © 2020 Vijay. All rights reserved.
//



import Foundation
import UIKit

@objcMembers class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    let repository: Repository
    
    init(navigationController: UINavigationController, repository: Repository) {
        self.repository = repository
        self.navigationController = navigationController
        self.navigationController.navigationBar.isTranslucent = true
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
    }
   
    func start() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let movieListController = storyboard.instantiateViewController(identifier: "MovieListController") as! MovieListController
        let viewModel = MovieListViewModel(viewDelegate: movieListController, coordinatorDelaget: self, repository: self.repository)
        movieListController.viewModl = viewModel
        self.navigationController.viewControllers = [movieListController]

    }
    
    // add coordinator append
    func addCoordinator(coordinator: Coordinator) {
        if !childCoordinator.contains(where: { $0 === coordinator}) {
            childCoordinator.append(coordinator)
        }
    }
    
    // remove coordinator releade coordinator
    func removeCoordinator(coordinator: Coordinator) {
        childCoordinator = childCoordinator.filter { $0 !== coordinator }
    }
    
    deinit {
        print("deinitialize App coodinator")
    }
}



extension AppCoordinator: MovieListCoordinatorDelegate {
    func movieViewModelDidProceedViewDetails(viewModel: MovieListViewModel, with movie: MoviesModel) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let movieDeailListController = storyboard.instantiateViewController(identifier: "MoviewDetailViewController") as! MoviewDetailViewController
        let viewModel = MovieDetailViewModel(coordinatorDelaget: self, repository: self.repository, selectedMovie: movie)
        movieDeailListController.viewModel = viewModel
        self.navigationController.pushViewController(movieDeailListController, animated: true)

    }
    
}
