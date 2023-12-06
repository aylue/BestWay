//
//  Journey.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 16.11.23.
//

import Foundation

//struct RouteSection : Identifiable {
//  var id = UUID()
//  var transport : TransportType
//  var startTime : String
//  var arrivalTime : String
//  var start : String
//  var stop : String
//  var distance : Float // in km
//}

struct RouteSection : Identifiable {
  var id = UUID()
  var name : String = ""
  var transport : TransportType
  var startTime : String
  var arrivalTime : String
  var start : String
  var stop : String
  var distance : Float // in km
}

class Journey {
  var dateFormatter = DateFormatter()
  var safeRoute : [RouteSection] = []
  var fastRoute : [RouteSection] = []
  var sustainableRoute : [RouteSection] = []

  init(safeRoute: [RouteSection], fastRoute: [RouteSection], sustainableRoute: [RouteSection]) {
    self.safeRoute = safeRoute
    self.fastRoute = fastRoute
    self.sustainableRoute = sustainableRoute
    dateFormatter.dateFormat = "yyyyMMdd-HHmm"
  }

  func totalDuration(route: [RouteSection]) -> Float {
    var total : Float = 0
    dateFormatter.dateFormat = "yyyyMMdd-HHmm"
    for section in route {
      total += Float(((dateFormatter.date(from: section.startTime)?.distance(to: dateFormatter.date(from: section.arrivalTime)!) ?? 0) / 60))
    }
    return total
  }

  func totalDistance(route: [RouteSection]) -> Float {
    var total : Float = 0
    for section in route {
      total += section.distance
    }
    return total
  }

  func totalEmissions(route: [RouteSection]) -> Int {
    var total : Int = 0
    for section in route {
      total += Int(Float(section.transport.emissions) * section.distance)
    }
    return total
  }

  static func formatTime(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd-HHmm"
    let date : Date = dateFormatter.date(from: dateString) ?? Date()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
  }

  static func sectionDuration(section: RouteSection) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd-HHmm"
    return Int(((dateFormatter.date(from: section.startTime)?.distance(to: dateFormatter.date(from: section.arrivalTime)!) ?? 0) / 60))
  }
 }


