/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of all of the landmarks.
*/

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    enum Tab {
        case featured
        case list
    }

    var body: some View {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            //View in phone
            TabView(selection: $selection) {
                CategoryHome() //CategoryHome View
                    .tabItem {
                        Label("Featured", systemImage: "star") //Sets image to tabView in phone View
                    }
                    .tag(Tab.featured)
                    .environmentObject(ModelData())

                LandmarkList() //LandmarkList View
                    .tabItem {
                        Label("List", systemImage: "list.bullet") //Sets image to tabView in phone View
                    }
                    .tag(Tab.list)
                    .environmentObject(ModelData())
            }
        } else {
            //View on other IOS devices
            CategoryHome()
                .environmentObject(ModelData())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
