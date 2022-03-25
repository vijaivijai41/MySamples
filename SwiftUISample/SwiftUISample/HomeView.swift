//
//  HomeView.swift
//  SwiftUISample
//
//  Created by Vijay on 19/08/20.
//

import Foundation
import SwiftUI
import ServiceProvider
import WidgetKit


struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.homeViewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch homeViewModel.apiState {
                case DataUpdateState.onloading:
                    Text("loading")
                case DataUpdateState.dataUpdate:
                    List(homeViewModel.allLists, id: \.title) { info in
                        Button(action: {
                            self.reloadWidget(id: String(info.id))
                        }) {
                            NavigationLink(
                                destination: HomeDetailView(viewModel: HomeDetailViewModel(repository: homeViewModel.repository, id: String(info.id))),
                                label: {
                                    HStack {
                                        Text(info.title).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            )
                        }
                        
                    }
                case DataUpdateState.dateError(let error):
                    Text(error)
                }
            }.navigationBarTitle(Text("MyList")).navigationBarHidden(false).foregroundColor(.orange)
        }
    }
    
    func reloadWidget(id: String) {
        if let userDefaults = UserDefaults(suiteName: "group.com.fundsindia.todaysWidget"){
            userDefaults.set(id, forKey: "SelectedNumber")
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
