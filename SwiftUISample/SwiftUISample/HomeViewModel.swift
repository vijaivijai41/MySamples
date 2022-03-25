//
//  HomeViewModel.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//

import Foundation
import SwiftUI
import ServiceProvider



class HomeViewModel: APPDataUpdateProtocol, ObservableObject {
    @Published var apiState: DataUpdateState = .onloading
    
    let repository: Repository
    var allLists: [InfoModel] = []
    init(repository: Repository = Repository(dataStore: DataStore.shared, apiHandler: WebserviceHandler())) {
        self.repository = repository
        loadList()
    }

    func loadList() {
        repository.fetchAllLists { (result) in
            switch result {
            case .success(let value):
                self.allLists.removeAll()
                self.apiState = .dataUpdate
                self.allLists.append(contentsOf: value)
                
            case .failure(let error):
                print(error.errorString)
                self.apiState = .dateError(error: error.errorString)
            }
        }
    }
    
    func didSelectItem(view: HomeView, didSelect item: InfoModel) {
       
    }
}
