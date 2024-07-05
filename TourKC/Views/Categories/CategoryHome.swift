/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false

    var body: some View {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            NavigationView {
                List {
                    PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                    
                    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: modelData.categories[key]!)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                .navigationTitle("Featured")
            }
        } else {
            NavigationView {
                LandmarkList()
                    .environmentObject(modelData)
                    .navigationTitle(modelData.shown == "" ? "Search": "Featured")
                    .navigationBarHidden(true)
                if (modelData.shown == "") {
                    List {
                        PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                            .aspectRatio(3 / 2, contentMode: .fit)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                            CategoryRow(categoryName: key, items: modelData.categories[key]!)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(.inset)
                    .navigationViewStyle(.columns)
                    .navigationTitle("Featured")
                } else {
                    LandmarkDetail(landmark: modelData.names2landmark(names: [modelData.shown])[0])
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            //.navigationViewStyle(.stack)
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
