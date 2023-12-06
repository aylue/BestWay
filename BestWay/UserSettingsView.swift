//
//  UserSettings.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 17.11.23.
//

import SwiftUI

struct UserSettingsView: View {
  @Binding var user : User
  var body: some View {
    VStack(alignment: .leading,spacing: 10) {
      HStack{Spacer()}
      Text("Preferences")
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      ScrollView {
        VStack(alignment: .leading){
          Group{
            Text("About you")
              .font(.title2)
            Text("We ask for your personal information to provide the best service possible. Your gender and age will be taken into account when chosing the best route, i.e. to improve your security during your journey.")
              .font(.caption)
            Text("Gender")
              .font(.headline)
              .padding(.top, 10)
            HStack{
              Image(systemName: "figure.dress.line.vertical.figure")
              Picker("Gender", selection: $user.gender) {
                ForEach(Gender.allCases) { gender in
                  Text(gender.rawValue)
                }
              }
            }
            .pickerStyle(.segmented)
          }
          Group{
            Text("Age")
              .font(.headline)
              .padding(.top, 10)
            Picker("Age", selection: $user.age) {
              ForEach(14 ..< 80) { number in
                Text("\(number)")
              }
            }
            .pickerStyle(.wheel)
          }
          Group{
            Text("Company")
              .font(.headline)
              .padding(.top, 10)
            Text("If you have children or pets, we will give you the option to take these into account when finding the best route.")
              .font(.caption)
            HStack{
              Image(systemName: "figure.2.and.child.holdinghands")
              Toggle(isOn: $user.children, label: {
                Text("Are you occasionally accompanied by children?")
                  .font(.caption)
              })
            }
            HStack{
              Image(systemName: "pawprint")
              Toggle(isOn: $user.pets, label: {
                Text("Are pets traveling with you from time to time?")
                  .font(.caption)
              })
            }
          }

          Group{
            Text("Disabilities")
              .font(.headline)
              .padding(.top, 10)
            HStack{
              Image(systemName: "figure.roll")
              Toggle(isOn: $user.disabled, label: {
                Text("Do you have physical impairments, i.e. need for a wheelchair?")
                  .font(.caption)
              })
            }
            HStack{
              Image(systemName: "poweroutlet.type.h")
              Toggle(isOn: $user.disabled, label: {
                Text("Is your vision impaired?")
                  .font(.caption)
              })
            }
          }
        }
        VStack(alignment: .leading) {
          HStack{Spacer()}
          Text("Your travel options")
            .font(.title2)
          Text("To find the best route for you and only show relevant information, please tell us what kind of inidivual transport you can use.")
            .font(.caption)
          Group {
            Text("Car")
              .font(.headline)
              .padding(.top, 10)
            HStack{
              Image(systemName: "car.2")
              Toggle(isOn: $user.hasDrivingLicense, label: {
                Text("Do you have a drivers license?")
                  .font(.caption)
              })
            }
            HStack{
              Image(systemName: "car")
              Toggle(isOn: $user.ownsCar, label: {
                Text("Do you own a car?")
                  .font(.caption)
              })
              .disabled(!user.hasDrivingLicense)
            }
            HStack{
              Image(systemName: "bolt.car")
              Toggle(isOn: $user.electricVehicle, label: {
                Text("Is your car an electric vehicle?")
                  .font(.caption)
              })
              .disabled(!user.ownsCar)
            }
            HStack{
              Image(systemName: "fuelpump")
              Text("How much gasoline does your car need on 100 km?")
                .font(.caption)
              Spacer()
              TextField("Gas", value: $user.carEmissions, format: .number)
                .keyboardType(.decimalPad)
                .frame(maxWidth: 35)
                .padding(3)
                .padding(.leading, 10)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .disabled(user.electricVehicle || !user.ownsCar)
            }
          }
          Group {
            Text("Other")
              .font(.headline)
              .padding(.top, 10)
            HStack{
              Image(systemName: "bicycle")
              Toggle(isOn: $user.disabled, label: {
                Text("Do you own a bike?")
                  .font(.caption)
              })
            }
          }
        }
      }
    }
    .padding(15)
  }
}

#Preview {
  UserSettingsView(user: .constant(AppSettings.appUser))
}
