//
//  ContentView.swift
//  SampleSwiftUi
//
//  Created by Vijay on 06/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 10.0) {
                    Image("shopping-list").resizable().frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .center).padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
                    Text("Hi1")
                    Text("Hi1")
                    Text("Hi1")
                    Text("Hi1")
                    Text("Hi1")
                    HStack {
                        Spacer()
                        
                        
                        TextField("Enter name", text: $name, onEditingChanged: { (isChanged) in
                            
                        }) {
                            
                        }
                        .padding(.horizontal, 10)
                                               .border(Color.black)
                                    .cornerRadius(3)
                                .keyboardType(.default)
                            
                    }.padding(.all, 20)
                        
                    .background(Color.red)
                        
                    NavigationLink(destination: OtherExampleView()) {
                        Text("Show List")
                    }
                    Text("Show Collection")
                    
                    
                }
                .padding(.all, 20.0)
            }
            .navigationBarTitle(Text("Home")).navigationBarHidden(false)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct OtherExampleView: View {
    
    func loadData()->[String] {
        return ["Apple","Amazon","Microsoft"]
    }
    
    var body: some View {
        
        List(loadData(),id: \.self) { pokemon in
            
            HStack {
                Image("apple").resizable().frame(width: 100, height: 80, alignment: .leading).aspectRatio(contentMode: .fit)
                
               NavigationLink(destination: ListView()) {
                    Text(pokemon)
                                      .font(.body)
                                      .fontWeight(.regular)
                                      .multilineTextAlignment(.leading)
                                      .padding(.all)
                                      .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
               }
                
            }
        }
            
        .navigationBarTitle(Text("List"))
    }
}


struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        OtherExampleView()
    }
}


