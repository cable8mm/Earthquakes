//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by samgu.lee on 14/12/23.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
