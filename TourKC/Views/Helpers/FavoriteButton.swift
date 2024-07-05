/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A button that acts as a favorites indicator.
*/

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var name: String
    let defaults = UserDefaults.standard

    var body: some View {
        Button {
            isSet.toggle()
            defaults.set(isSet, forKey: name + "_fav")
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true), name: "test")
    }
}
