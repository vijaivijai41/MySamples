//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Vijay on 06/08/20.
//

import WidgetKit
import SwiftUI
import Intents
import Services


struct Provider: IntentTimelineProvider {
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<ImageEntry>) -> Void) {
        var entries: [ImageEntry] = []
        let currentDate = Date()
    
        for hourOffset in 0 ..< 6 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset*10, to: currentDate)!
            let id = self.getCurrentValue()
            print(id)
            
                WebCall.imagesFetch(id: id) { (result) in
                let serverData: ImageModel
                
                if case .success(let fetchedServerData) = result {
                    serverData = fetchedServerData
                } else {
                    serverData = ImageModel(id: 1, title: "This is sample title")
                    print ("Please set a server for widget")
                }
                let entry =  ImageEntry(date: entryDate, images: serverData, configuration: configuration)
                entries.append(entry)

            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }

    }
    
    func placeholder(in context: Context) -> ImageEntry {
        
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (ImageEntry) -> Void) {
        let id = self.getCurrentValue()
        WebCall.imagesFetch(id: id) { (result) in
            let serverData: ImageModel
            
            if case .success(let fetchedServerData) = result {
                serverData = fetchedServerData
            } else {
                serverData = ImageModel(id: 1, title: "This is sample title")
                print ("Please set a server for widget")
            }
            
            let entry =  ImageEntry(date: Date(), images: serverData, configuration: configuration)
            completion(entry)
        }
    }
    
   
    typealias Entry = ImageEntry
    
    typealias Intent = ConfigurationIntent
        
    func getCurrentValue() -> String {
        var str =  ""
        if let userDefaults = UserDefaults(suiteName: "group.myGroup.Sample") {
            str = userDefaults.string(forKey: "SelectedNumber") ?? ""
        }
        return str
        
    }
}



struct WebCall {
    
    static func imagesFetch(id: String, onCompletion: @escaping(Result<ImageModel, ErrorHandler>) ->()){
        let repository: Repository = Repository(dataStore: DataStore.shared, apiHandler: WebserviceHandler())
        let resource = DataNetworkResource.fetchList(id: id)
        repository.fetchAnimalImage(resource: resource, onCompletion: onCompletion)
    }
}

struct ImageEntry: TimelineEntry {
    var date: Date
    public let images: ImageModel?
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                Text(entry.images?.title ?? "")
                    .font(.callout)
                    .padding(10)
                    .foregroundColor(.white)
            }.background(Color.green)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(10)
        case .systemMedium:
            ZStack {
                Text(entry.images?.title ?? "")
                    .font(.callout)
                    .padding(10)
                    .foregroundColor(.white)
            }.background(Color.green)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(10)
        case .systemLarge:
            ZStack {
                Text(entry.images?.title ?? "")
                    .font(.callout)
                    .padding(10)
                    .foregroundColor(.white)
            }.background(Color.green)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(10)
        default:
            ZStack {
                Text(entry.images?.title ?? "")
                    .font(.callout)
                    .padding(10)
                    .foregroundColor(.white)
            }.background(Color.green)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(10)
        }
    }

}

@main
struct WidgetExtension: Widget {
    private let kind: String = "WidgetExtension"

    public var body: some WidgetConfiguration {
    
        IntentConfiguration<ConfigurationIntent>(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider(),
            placeholder: PlaceholderView() ){ entry in
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Picture Box")
        .description("View a picture on your home screen.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtensionEntryView(entry: ImageEntry(date: Date(), images: nil, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
