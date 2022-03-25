//
//  HomeDetailView.swift
//  SwiftUISample
//
//  Created by Vijay on 20/08/20.
//

import SwiftUI
import ServiceProvider

public struct HomeDetailView: View {
    @ObservedObject var detailViewModel: HomeDetailViewModel
    
    init(viewModel: HomeDetailViewModel) {
        self.detailViewModel = viewModel
        
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                switch detailViewModel.apiState {
                case DataUpdateState.onloading:
                    Text("Onloaing....")
                case DataUpdateState.dataUpdate:
                    Text(self.detailViewModel.apiResponseModel?.title ?? "")
                case DataUpdateState.dateError(let error):
                    Text(error)
                }
            }.onAppear {
                self.detailViewModel.loadDetail(id: detailViewModel.selectedId)
            } .onDisappear {
                print("on disappear")
            }
        }
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(viewModel: HomeDetailViewModel(repository: Repository(dataStore: DataStore.shared, apiHandler: WebserviceHandler()), id: "1"))
    }
}
