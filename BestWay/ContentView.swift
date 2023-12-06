//
//  ContentView.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 08.11.23.
//

import SwiftUI

struct ContentView: View {

  @State var destinationName : String = "Accenture München, Balanstraße 73"
  @State var startName : String = "Augustiner Stamhaus, Neuhauser Straße 27, 80331 München"
  @State var showSheet : Bool = false
  @Binding var appUser : User
  @State private var date = Date()
  @State private var tabViewPage = 1

  @State var needs = [
    ItemData(name: "Stay clean", imageName: "sun.max.fill"),
    ItemData(name: "Pet", imageName: "pawprint.fill"),
    ItemData(name: "Luggage", imageName: "bag.fill"),
    ItemData(name: "Children", imageName: "figure.and.child.holdinghands"),
    ItemData(name: "Reliable", imageName: "clock.badge.exclamationmark"),
    ItemData(name: "Work", imageName: "laptopcomputer")
  ]

  @State var selection_needs : [ItemData] = []

  @State var modesOfTransport : [ItemData] = [
    ItemData(name: "Car", imageName: "car"),
    ItemData(name: "Train", imageName: "train.side.front.car"),
    ItemData(name: "Bus", imageName: "bus"),
    ItemData(name: "TRAM", imageName: "tram"),
    ItemData(name: "Bike", imageName: "bicycle"),
    ItemData(name: "Walking", imageName: "figure.walk"),
    ItemData(name: "Rented Car", imageName: "car.circle"),
    ItemData(name: "Rented Bike", imageName: "bicycle.circle"),
    ItemData(name: "E-Scooter", imageName: "scooter"),
  ]

  @State var selection_transport : [ItemData] = []

  @State var capabilities : [ItemData] = []


  let transportModes : [String] = ["bus.fill", "train.side.front.car", ]
  var body: some View {
    NavigationStack{
      VStack{
        // Main Body
        VStack{
          // Start new Journey
          VStack{
            HStack{
              Spacer()
              Text("New Journey")
                .font(.headline)
              Spacer()

            }
            HStack{
              VStack{
                TextField("Start", text: $destinationName)
                HStack{
                  Image(systemName: "arrow.down.app.fill")
                  VStack{Divider()}
                }
                TextField("Destination", text: $startName)
              }
              Image(systemName: "arrow.up.right.and.arrow.down.left.rectangle")
            }
            Button(action: {
              print("Hey, you go!")
            }, label: {
              HStack{
                Spacer()
                NavigationLink(destination: {
                  if(selection_transport.isEmpty) {
                    JourneyView(
                      journeyDate: date,
                      dummyJourney: AppSettings.journeyNoConditions)
                  }
                  else {
                    JourneyView(
                      journeyDate: date,
                      dummyJourney: AppSettings.journeyConditions)
                  }
                }, label: {
                  Text("Find my route")
                    .foregroundColor(Color.white)
                    .padding(15)
                })
                Spacer()
              }
            })
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.4),radius: 5)
            .padding(.vertical, 15)
          }
          .padding(15)
          .foregroundColor(Color.black
            .opacity(0.7))
          .background(
            Color.white
              .opacity(0.4))
          .clipShape(RoundedRectangle(cornerRadius: 20))

        }
        .padding(.bottom, 15)

        Spacer()

        VStack{
          // What is available?
          Text("Travel Settings")
            .font(.headline)
            .padding(.horizontal, 15)
            .padding(.top, 10)

          // Date and Time
          HStack{
            Text("Start time")
              .font(.headline)
              .padding(.horizontal, 10)
            Spacer()
          }
          Group {
            DatePicker(
              "Date",
              selection: $date,
              displayedComponents: [.date, .hourAndMinute]
            )
          }
          .padding(.horizontal, 15)

          HStack{
            Text("Your needs")
              .font(.headline)
              .padding(.horizontal, 15)
            Spacer()
          }
          TabView(selection: $tabViewPage, content: {
            VStack{
              SelectionList(dummyData: $needs, selections: $selection_needs)
              Spacer()
              Text("Got special circumstances such as a pet traveling with you? Select what is important to your next journey!")
                .font(.caption)
                .padding(10)
              Spacer()
            }
            .tag(1)

            VStack{
              SelectionList(dummyData: $modesOfTransport, selections: $selection_transport, color: .red)
            Spacer()
              Text("Select which modes of transport you want to ignore when planning routes")
                .font(.caption)
                .padding(10)
              Spacer()
            }
            .tag(2)
          })
          .tabViewStyle(.page(indexDisplayMode: .automatic))
          .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
          HStack{
            Spacer()
            Button(action: {
              showSheet.toggle()
            }, label: {
              HStack{
                Image(systemName: "gear")
                Text("Show User Settings")
              }
            })
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
          }
        }
        .background(Color.white
          .opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 15))
      }
      .padding(20)
      .padding(.bottom, 0)
      .background(
        Gradient(colors: [Color.purple, Color.blue])
          .opacity(0.5))
      .sheet(isPresented: $showSheet, content: {
        UserSettingsView(user: $appUser)
      }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    @State var appUser = AppSettings.appUser
    ContentView(appUser: $appUser)
  }
}
