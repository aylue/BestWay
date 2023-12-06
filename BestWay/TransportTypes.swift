//
//  TransportTypes.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 12.11.23.
//

import Foundation

enum TypeOfTransport: String {
  case Bus = "Bus"
  case Car = "Car"
  case Train = "Train"
  case Subway = "Subway"
  case EScooter = "E-Scooter"
  case Bike = "Bicycle"
  case Ebike = "E-Bike"
  case Tram = "Tram"
  case Walking = "Walking"
  case RentCar = "Rented Car"
  case RentBike = "Rented Bicycle"

}

struct TransportType {
  var typeOfTransport : TypeOfTransport
  var icon: String
  var emissions: Int
}

class Transport {
  let car = TransportType(typeOfTransport: .Car, icon: "car", emissions: AppSettings.appUser.getCarEmissions())
  let bus = TransportType(typeOfTransport: .Bus, icon: "bus", emissions: 25)
  let train = TransportType(typeOfTransport: .Train, icon: "train.side.front.car", emissions: 10)
  let subway = TransportType(typeOfTransport: .Subway, icon: "tram.fill.tunnel", emissions: 10)
  let tram = TransportType(typeOfTransport: .Tram, icon: "tram", emissions: 5)
  let bicycle = TransportType(typeOfTransport: .Bike, icon: "bicycle", emissions: 0)
  let walking = TransportType(typeOfTransport: .Walking, icon: "figure.walk", emissions: 0)
  let escooter = TransportType(typeOfTransport: .EScooter, icon: "scooter", emissions: 5)
  let rented_car = TransportType(typeOfTransport: .RentCar, icon: "car.circle", emissions: 100)
}
