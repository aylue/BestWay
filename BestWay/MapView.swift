//
//  MapView.swift
//  BestWay
//
//  Created by Ayleen Lührsen on 27.11.23.
//

import SwiftUI

struct MapView: View {
  @State private var currentZoom = 0.5
  @State private var totalZoom = 1.0
  var map : String = "Map.png"

  var body: some View {
    VStack{
      Image("Map.png")
        .scaledToFill()
        .background(.gray)
        .scaleEffect(currentZoom + totalZoom)
        .gesture(
          MagnifyGesture()
            .onChanged { value in
              currentZoom = value.magnification - 1
            }
            .onEnded { value in
              totalZoom += currentZoom
              currentZoom = 0
            }
        )
        .accessibilityZoomAction { action in
          if action.direction == .zoomIn {
            totalZoom += 1
          } else {
            totalZoom -= 1
          }
        }
    }
  }
}

#Preview {
  MapView()
}
