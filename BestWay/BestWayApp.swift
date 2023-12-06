//
//  BestWayApp.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 08.11.23.
//

import SwiftUI

@main
struct BestWayApp: App {

  var body: some Scene {
    WindowGroup {
      @State var user = User()
      ContentView(appUser: $user)
    }
  }
}

class AppSettings {
  static var appUser = User()
  static var transportOptions = Transport()
  static var journeyNoConditions = Journey(
    safeRoute: [RouteSection(
      name: "Own car",
      transport: AppSettings.transportOptions.car,
      startTime: "20231202-1615",
      arrivalTime: "20231202-1635",
      start: "Accenture Office München",
      stop: "Schlossbrauerei Herrngiershof",
      distance: 13)
    ],
    fastRoute: [
      RouteSection(
        name: "Own car",
        transport: AppSettings.transportOptions.car,
        startTime: "20231202-1615",
        arrivalTime: "20231202-1635",
        start: "Accenture Office München",
        stop: "Schlossbrauerei Herrngiershof",
        distance: 13)
    ],
    sustainableRoute: [
      RouteSection(
        name: "Lime Scooter",
        transport: AppSettings.transportOptions.escooter,
        startTime: "20231202-1615",
        arrivalTime: "20231202-1655",
        start: "Accenture Office München",
        stop: "Schlossbrauerei Herrngiershof",
        distance: 11)
    ])

  static var journeyConditions = Journey(
    safeRoute: [
      RouteSection(
        name: "S7",
        transport: AppSettings.transportOptions.train,
        startTime: "20231202-1615",
        arrivalTime: "20231202-1635",
        start: "Accenture Office München",
        stop: "München HBF",
        distance: 13),
      RouteSection(
        name: "SIXXT Car",
        transport: AppSettings.transportOptions.rented_car,
        startTime: "20231202-1640",
        arrivalTime: "20231202-1655",
        start: "München HBF",
        stop: "Willibaldsplatz",
        distance: 13),
      RouteSection(
        name: "Walk",
        transport: AppSettings.transportOptions.walking,
        startTime: "20231202-1655",
        arrivalTime: "20231202-1658",
        start: "Willibaldsplatz",
        stop: "Schlossbrauerei Herrngiershof",
        distance: 13)
    ],
    fastRoute: [
      RouteSection(
        name: "Cambio car",
        transport: AppSettings.transportOptions.car,
        startTime: "20231202-1615",
        arrivalTime: "20231202-1640",
        start: "Accenture Office München",
        stop: "Schlossbrauerei Herrngiershof",
        distance: 13)
    ],
    sustainableRoute: [
      RouteSection(
        name: "S7",
        transport: AppSettings.transportOptions.train,
        startTime: "20231202-1615",
        arrivalTime: "20231202-1635",
        start: "Accenture Office München",
        stop: "München HBF",
        distance: 13),
      RouteSection(
        name: "TRAM 19",
        transport: AppSettings.transportOptions.tram,
        startTime: "20231202-1640",
        arrivalTime: "20231202-1700",
        start: "München HBF",
        stop: "Willibaldsplatz",
        distance: 13),
      RouteSection(
        name: "Walk",
        transport: AppSettings.transportOptions.walking,
        startTime: "20231202-1700",
        arrivalTime: "20231202-1703",
        start: "Willibaldsplatz",
        stop: "Schlossbrauerei Herrngiershof",
        distance: 13)
    ])
}
