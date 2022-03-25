//
//  ContentView.swift
//  StateMain
//
//  Created by Vijay on 10/09/20.
//

import SwiftUI
import WidgetKit

class DelayedUpdater: ObservableObject {
    @Published var value = 0

    init() {
        for i in 1...100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}



struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
