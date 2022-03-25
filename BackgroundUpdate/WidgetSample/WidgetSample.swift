//
//  WidgetSample.swift
//  WidgetSample
//
//  Created by Vijay on 21/10/20.
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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WidgetSampleEntryView : View {
    var entry: Provider.Entry

    @EnvironmentObject var updater: DelayedUpdater

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

@main
struct WidgetSample: Widget {
    let kind: String = "WidgetSample"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetSampleEntryView(entry: entry).environmentObject(DelayedUpdater())
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WidgetSample_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall)).environmentObject(DelayedUpdater())
    }
}
