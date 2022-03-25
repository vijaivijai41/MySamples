//
//  HomeDetailViewModel.swift
//  SwiftUISample
//
//  Created by Vijay on 20/08/20.
//

import Foundation
import ServiceProvider
import WidgetKit


public class HomeDetailViewModel: APPDataUpdateProtocol, ObservableObject {
    @Published public var apiState: DataUpdateState = .onloading
    
    public let repository: Repository
    public let selectedId: String
    public var apiResponseModel: InfoModel? = nil
    
    public init(repository: Repository, id: String) {
        self.repository = repository
        self.selectedId = id
       
    }
    
    public func loadDetail(id: String) {
        repository.fetchSelectedItem(id: id) { (result) in
            switch result {
            case .success(let model):
                self.apiResponseModel = model
                self.apiState = .dataUpdate
            case .failure( let error):
                self.apiState = .dateError(error: error.errorString)
            }
        }
    }
}
