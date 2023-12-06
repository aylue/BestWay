//
//  User.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 12.11.23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
  case FEMALE = "Female"
  case MALE = "Male"
  case OTHER = "non-binary"
  
  var id: Self { self }
}


class User: ObservableObject {

  var ownsCar: Bool
  var electricVehicle: Bool
  var hasDrivingLicense: Bool
  var carEmissions: Float
  var ownsBike: Bool
  var children: Bool
  var pets: Bool
  var disabled: Bool
  var blind: Bool
  var gender: Gender
  var age: Int

  init() {
    self.ownsCar = true
    self.electricVehicle = true
    self.hasDrivingLicense = true
    self.carEmissions = 6
    self.ownsBike = true
    self.children = false
    self.pets = false
    self.disabled = false
    self.blind = false
    self.gender = .FEMALE
    self.age = 25
  }

  func getCarEmissions() -> Int {
    if electricVehicle {
        return 10
    }
    else {
      return Int(carEmissions/10)
    }
  }

}
