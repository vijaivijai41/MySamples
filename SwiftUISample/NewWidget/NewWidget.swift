//
//  NewWidget.swift
//  NewWidget
//
//  Created by Vijay on 27/08/20.
//

import WidgetKit
import SwiftUI
import Intents

import ServiceProvider
let webCall: Webcall = Webcall(repository: Repository(dataStore: DataStore.shared, apiHandler: WebserviceHandler()))

var newRefreshDate: Date = Date()
var initialized: Bool = false

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        webCall.apiState = .onloading
        let value = self.getCurrentValue()
        webCall.loadDetail(id: value) { (result) in
            let serverData: InfoModel
            
            switch result {
            case .success(let model):
                serverData = model
                webCall.apiState = .dataUpdate
            case .failure(let error):
                webCall.apiState = .dateError(error: error.errorString)
                serverData = InfoModel(id: 1, title: "Hi sample loaded")
            }
            let entry = SimpleEntry(date: Date(), configuration: configuration, infoModel: serverData)
            completion(entry)
        }
       
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        webCall.apiState = .onloading
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let idValue = self.getCurrentValue()
        let refreshDate = Calendar.current.date(byAdding: .second, value: 1, to: currentDate)!
        
        webCall.loadDetail(id: idValue) { (result) in
            var infoModel: InfoModel
            
            if case let Result.success(model) = result {
                infoModel = model
                webCall.apiState = .dataUpdate
            } else {
                webCall.apiState = .dateError(error: "Loading failure")
                infoModel = InfoModel(id: 1, title: "Ho this is sample")
            }
            
            let entry = SimpleEntry(date: currentDate, configuration: configuration, infoModel: infoModel)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }        
    }
    
    func getCurrentValue() -> String {
        var str =  ""
        if let userDefaults = UserDefaults(suiteName: "group.com.fundsindia.todaysWidget") {
            str = userDefaults.string(forKey: "SelectedNumber") ?? ""
        }
        return str
    }

}




public class Webcall: APPDataUpdateProtocol, ObservableObject {
    @Published public var apiState: DataUpdateState = .onloading
    
    public let repository: Repository
    public var apiResponseModel: InfoModel? = nil
    
    public init(repository: Repository) {
        self.repository = repository
        
    }
    
    public func loadDetail(id: String, onCompletion: @escaping(Result<InfoModel, ErrorHandler>) -> ()) {
        repository.fetchSelectedItem(id: id) { (result) in
            switch result {
            case .success(let model):
                self.apiResponseModel = model
                self.apiState = .dataUpdate
                onCompletion(.success(model))
            case .failure( let error):
                self.apiState = .dateError(error: error.errorString)
                onCompletion(.failure(error))
            }
        }
    }
}


struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
    public let infoModel: InfoModel
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct NewWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.infoModel.title)
        }
    }
}

@main
struct NewWidget: Widget {
    private let kind: String = "NewWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            NewWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct NewWidget_Previews: PreviewProvider {
    static var previews: some View {
        NewWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), infoModel: InfoModel(id: 1, title: "My Sample Widget")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
