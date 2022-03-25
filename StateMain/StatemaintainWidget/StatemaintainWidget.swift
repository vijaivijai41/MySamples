//
//  StatemaintainWidget.swift
//  StatemaintainWidget
//
//  Created by Vijay on 15/10/20.
//

import WidgetKit
import SwiftUI
import Intents


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

struct Provider: IntentTimelineProvider {
    let date = Date()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(status: "Populating", date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(status: "Populating", date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [SimpleEntry] = []

        let currentDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970)

        // Creating a timeline for the next 1 hour. Widget is only refresh a limited
        // number of times, so it is best to have timeline ready for a long time.
        for secondOffset in 0 ..< 3600 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let entry = SimpleEntry(status: String(Int.random(in: 0 ..< 1000)), date: entryDate, configuration: configuration)
            entries.append(entry)
            
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let status: String
    let date: Date
    let configuration: ConfigurationIntent
}

struct StatemaintainWidgetEntryView : View {
    var entry: Provider.Entry

    @EnvironmentObject var updater: DelayedUpdater

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

@main
struct StatemaintainWidget: Widget {
    let kind: String = "StatemaintainWidget"
    let delayedUpdaet = DelayedUpdater()

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            StatemaintainWidgetEntryView(entry: entry).environmentObject(delayedUpdaet)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct StatemaintainWidget_Previews: PreviewProvider {
    static var previews: some View {
        StatemaintainWidgetEntryView(entry: SimpleEntry(status: "Populating", date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall)).environmentObject(DelayedUpdater())
    }
}
