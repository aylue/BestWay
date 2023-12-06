//
//  ContentView.swift
//  MultiSelector
//
//  Created by Florian Scholz on 10.11.23.
//

import SwiftUI

struct ItemData: Identifiable, Hashable {
  var id = UUID().uuidString
  var name: String
  var imageName: String

}

struct SelectionRow: View {
  var item: ItemData
  var isSelected: Bool
  var action: () -> Void
  var selectionColor: Color = .blue

  var body: some View {
    Button(action: self.action) {
      VStack {
        Image(systemName: item.imageName)
        Text(item.name)
      }
      .padding(10)
    }
    .foregroundStyle(isSelected ? .white : .blue)
    .background(selectionColor.opacity(isSelected ? 1.0 : 0.0))
    .clipShape(RoundedRectangle(cornerRadius: 35))
  }
}

struct SelectionList: View {
  @Binding var dummyData: [ItemData]

  @Binding var selections: [ItemData]

  var color: Color = .blue

  var body: some View {
    LazyVGrid(columns: [GridItem(.flexible(),spacing: 5), GridItem(.flexible(), spacing: 5),GridItem(.flexible(), spacing: 5)]
              , spacing: 0
              , content: {
      ForEach(self.dummyData, id: \.self) { item in
        SelectionRow(item: item, isSelected: self.selections.contains(item), action:  {
          if self.selections.contains(item) {
            self.selections.removeAll(where: { $0 == item })
          }
          else {
            self.selections.append(item)
          }
        }, selectionColor: color)
      }
    })
  }
}

struct SelectionList_Previews: PreviewProvider {
  static var previews: some View {
    @State var appUser = AppSettings.appUser
    ContentView(appUser: $appUser)
  }
}
