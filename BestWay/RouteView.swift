//
//  MapView.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 09.11.23.
//

import SwiftUI

struct JourneyView: View {
  @State private var scale : CGFloat = 1.0
  @State var selectedRoute : Int = 2
  var journeyDate: Date = Date()
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "de_DE")
    formatter.doesRelativeDateFormatting = true
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
  }()

  var dummyJourney: Journey = Journey(safeRoute: [
    RouteSection(
      transport: AppSettings.transportOptions.bus,
      startTime: "20231130-1322",
      arrivalTime: "20231130-1350",
      start: "Bremen HBF",
      stop: "Universität Süd",
      distance: 6),
    RouteSection(
      transport: AppSettings.transportOptions.walking,
      startTime: "20231130-1350",
      arrivalTime: "20231130-1355",
      start: "Universität Süd",
      stop: "Universität Mehrzweckhochhaus",
      distance: 0.4)
  ], fastRoute: [
    RouteSection(
      transport: AppSettings.transportOptions.bus,
      startTime: "20231130-1322",
      arrivalTime: "20231130-1350",
      start: "Bremen HBF",
      stop: "Universität Süd",
      distance: 6),
    RouteSection(
      transport: AppSettings.transportOptions.walking,
      startTime: "20231130-1350",
      arrivalTime: "20231130-1355",
      start: "Universität Süd",
      stop: "Universität Mehrzweckhochhaus",
      distance: 0.4)
  ], sustainableRoute: [
    RouteSection(
      transport: AppSettings.transportOptions.bus,
      startTime: "20231130-1322",
      arrivalTime: "20231130-1350",
      start: "Bremen HBF",
      stop: "Universität Süd",
      distance: 6),
    RouteSection(
      transport: AppSettings.transportOptions.walking,
      startTime: "20231130-1350",
      arrivalTime: "20231130-1355",
      start: "Universität Süd",
      stop: "Universität Mehrzweckhochhaus",
      distance: 0.4)
  ])


  var body: some View {
    VStack {
      //      Routenverlauf (Slide View) von fast, most sustainable, safe/productive
      TabView(selection: $selectedRoute, content: {
        RouteView(name: "Fast", gradientColors: [.red, .pink], icon: "hare", routeSections: dummyJourney.fastRoute)
          .tag(1)
          .padding(.horizontal,10)

        RouteView(name: "Sustainable", gradientColors: [Color.green, Color.teal], icon: "leaf", routeSections: dummyJourney.sustainableRoute)
          .tag(2)
          .padding(.horizontal,10)

        RouteView(name: "Safe", gradientColors: [.blue, .cyan], icon: "shield.righthalf.filled", routeSections: dummyJourney.safeRoute)
          .tag(3)
          .padding(.horizontal,10)
      })
      .tabViewStyle(.page(indexDisplayMode: .always))
      .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

      HStack {
        VStack(alignment: .leading){
          HStack(alignment: .top){
            Image(systemName: "calendar.badge.clock.rtl")
            Text(dateFormatter.string(from: journeyDate))
          }
        }
        .font(.title2)
        /** Anzeige von:
         - Nachhaltigkeitswerte (maximaler score zB 100)
         - Schaltfläche */
        //      Karte noch etwas kleiner
        Spacer()
        VStack(alignment: .trailing) {
          switch selectedRoute {
          case 1:
            HStack{
              Image(systemName: "stopwatch")
              Text("Total duration: " + String(dummyJourney.totalDuration(route: dummyJourney.fastRoute)) + " min")
            }
            HStack{
              Image(systemName: "arrow.triangle.swap")
              Text("Total distance: " + String(dummyJourney.totalDistance(route: dummyJourney.fastRoute)) + " km")
            }
            HStack{
              Image(systemName: "leaf")
              Text("CO2 Score: " + String(dummyJourney.totalEmissions(route: dummyJourney.fastRoute)))
            }
          case 2:
            HStack{
              Image(systemName: "stopwatch")
              Text("Total duration: " + String(dummyJourney.totalDuration(route: dummyJourney.sustainableRoute)) + " min")
            }
            HStack{
              Image(systemName: "arrow.triangle.swap")
              Text("Total distance: " + String(dummyJourney.totalDistance(route: dummyJourney.sustainableRoute)) + " km")
            }
            HStack{
              Image(systemName: "leaf")
              Text("CO2 Score: " + String(dummyJourney.totalEmissions(route: dummyJourney.sustainableRoute)))
            }
          case 3:
            HStack{
              Image(systemName: "stopwatch")
              Text("Total duration: " + String(dummyJourney.totalDuration(route: dummyJourney.safeRoute)) + " min")
            }
            HStack{
              Image(systemName: "arrow.triangle.swap")
              Text("Total distance: " + String(dummyJourney.totalDistance(route: dummyJourney.safeRoute)) + " km")
            }
            HStack{
              Image(systemName: "leaf")
              Text("CO2 Score: " + String(dummyJourney.totalEmissions(route: dummyJourney.safeRoute)))
            }
          default:
            HStack{
              Image(systemName: "stopwatch")
              Text("Total duration: " + " ")
            }
            HStack{
              Image(systemName: "arrow.triangle.swap")
              Text("Total distance: " + " ")
            }
            HStack{
              Image(systemName: "leaf")
              Text("CO2 Score: " + " ")
            }
          }

        }
        .font(.caption)
      }
      .padding(15)
      .foregroundColor(.black.opacity(0.8))
      HStack{
        NavigationLink(destination: MapView(), label: {
          HStack{
            Spacer()
            Image(systemName: "map.fill")
            Text("Show map")
              .font(.headline)
            Spacer()
          }
          .padding(.vertical, 10)
          .foregroundColor(.white)
        })
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
      }
    }
  }
}


struct RouteSectionsView: View {
  let routeSections : [RouteSection]
  let dateBuilder: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd-HHmm"
    return formatter
  }()
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "de_DE")
    formatter.doesRelativeDateFormatting = true
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
  }()

  var body: some View {
    VStack{
      ScrollView{
        VStack{
          HStack{
            Image(systemName: "mappin")
              .font(.title)
            Text("Start from:")
              .fontWeight(.bold)
            Spacer()
          }
          .padding(-15)
          .padding(.bottom, 10)
          ForEach(routeSections) { section in
            VStack(alignment: .leading) {
              HStack {
                Image(systemName: (section.transport.icon))
                  .font(.title)
                  .frame(maxWidth: 40)
                VStack(alignment: .leading) {
                  Text(section.name + " from " + section.start)
                  Text(String(section.distance) + " km")
                    .font(.caption)
                }
                Spacer()
                VStack(alignment: .trailing) {
                  Text(Journey.formatTime(dateString: section.startTime))
                  Text(String(Journey.sectionDuration(section: section)) + " min")
                    .font(.caption)
                }
              }
            }
            Divider()
          }
        }
        .padding(15)
      }
      HStack{
        Image(systemName: "flag.checkered")
          .font(.title)
        Text(routeSections.last!.stop)
          .font(.title3)
          .fontWeight(.bold)
        Spacer()
        Text(dateFormatter.string(from: dateBuilder.date(from: routeSections.last!.arrivalTime) ?? Date()))
          .font(.title3)
          .fontWeight(.bold)
      }
    }
    .foregroundColor(.white)
  }
}

struct RouteView: View{
  var name : String = "Default"
  var gradientColors : [Color] = [.black, .gray]
  var icon : String = "exclamationmark.triangle"
  var routeSections: [RouteSection]

  var body: some View {
    VStack{
      HStack{
        Text(name)
          .font(.title)
        Spacer()
        Image(systemName: icon)
          .font(.system(size: 50))
      }
      .foregroundColor(.white)
      .padding(15)
      Spacer()
      RouteSectionsView(routeSections: routeSections)
        .padding(.horizontal, 15)
        .padding(.bottom, 50)
      Spacer()
    }
    .background(Gradient(colors: gradientColors))
    .clipShape(RoundedRectangle(cornerRadius: 20))
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    JourneyView()
  }
}
