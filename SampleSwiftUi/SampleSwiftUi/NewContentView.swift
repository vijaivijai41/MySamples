//
//  NewContentView.swift
//  SampleSwiftUi
//
//  Created by Vijay on 07/11/19.
//  Copyright © 2019 Vijay. All rights reserved.
//

import Foundation
import SwiftUI

struct CityInfo {
    let name: String
    let desc: String
}


struct ListView: View {
    
    var lists:[CityInfo] = [CityInfo(name: "Chennai", desc: "SmartCity")
        ,CityInfo(name: "madurai", desc: "Temple city"),
         CityInfo(name: "salem", desc: "Granit city"),
         CityInfo(name: "covai", desc: "Textile city"),
         CityInfo(name: "trichi", desc: "clean city")]
    
    var body: some View {
        
        List(lists,id: \.name) { content in
            HStack {
                Image("apple").resizable().frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    Text(content.name).font(.body)
                    Text(content.desc)
                }
            }
        }
    }
}

struct ListView_Previewer: PreviewProvider {
     static var previews: some View {
           ListView()
    }
    
}
