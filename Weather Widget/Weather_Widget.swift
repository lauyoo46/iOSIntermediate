//
//  Weather_Widget.swift
//  Weather Widget
//
//  Created by Laurentiu Ile on 20/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetContent {
        WidgetContent(cityName: "Paris", weather: "Few Clouds", temperature: 2)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = WidgetContent(cityName: "Oradea", weather: "Sunny", temperature: 11)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetContent] = []
        var weatherData: WeatherData = WeatherData()
        let weatherViewController = WeatherViewController()
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: weatherViewController.city, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let safeData = data {
                    weatherData.weather = safeData.weather
                    weatherData.temperature = safeData.temperature
                    
                    let entry = WidgetContent(cityName: weatherViewController.city,
                                              weather: weatherData.weather,
                                              temperature: weatherData.temperature)
                    entries.append(entry)

                    let timeline = Timeline(entries: entries, policy: .after(entry.date))
                    completion(timeline)
                }
            })
        })
    }
}

struct WidgetContent: TimelineEntry {
    var date = Date()
    var cityName: String
    var weather: String
    var temperature: Int
}

struct Weather_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack() {
            Text(entry.cityName)
            Text(entry.weather)
            Text("\(entry.temperature)°")
        }
    }
}

@main
struct Weather_Widget: Widget {
    let kind: String = "Weather_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Weather_WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
    }
}

struct Weather_Widget_Previews: PreviewProvider {
    static var cityName = "Cluj-Napoca"
    static var weatherData = WeatherData(temperature: 5, weather: "Clouds")

    static var previews: some View {
        Weather_WidgetEntryView(entry: WidgetContent(cityName: cityName,
                                                     weather: weatherData.weather,
                                                     temperature: weatherData.temperature) )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
