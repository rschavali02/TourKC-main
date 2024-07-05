/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly: Bool = false //Starts app with favorite only feature off
    @State private var weatherOnly: Bool = false //Starts app with weather only feature off
    @State private var search: String = "" //enables the user to type strings
    @State private var filteredCategory: Landmark.Category? = nil //Starts app with no category filter
    @State private var filteredCharacteristic: Landmark.Characteristic? = nil //Starts app with no characteristic filter
    
    func set_cat(_ cat: Landmark.Category) { //Sets Categories to filter/update
        if filteredCategory == cat {
            filteredCategory = nil
        } else {
            filteredCategory = cat
        }
    }
    
    func set_char(_ cat: Landmark.Characteristic) { //Sets Characteristics to filter/update
        if filteredCharacteristic == cat {
            filteredCharacteristic = nil
        } else {
            filteredCharacteristic = cat
        }
    }

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite) //Filters By Favorite
        }
        .filter { landmark in
            (search == "" || landmark.name.contains(search)) // Filters by Search
        }
        .filter { landmark in
            (filteredCategory == nil || landmark.category == filteredCategory) //Filters by category
        }
        .filter { landmark in
            (filteredCharacteristic == nil || landmark.characteristic == filteredCharacteristic) //Filters by characteristic
        }
        .filter { landmark in
            (!weatherOnly || modelData.isWeatherPermit(landmark))
        }
    }

    var body: some View {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            NavigationView {
                List {
                    //HStack {
                    TextField("Search", text: $search)
                    Toggle("Favorites Only", isOn: $showFavoritesOnly)
                    if let _ = modelData.w {
                        Toggle("Weather-Based", isOn: $weatherOnly)
                    }
                    //}
                    HStack {
                        Menu {
                            ForEach(Landmark.Category.allCases, content: { cat in
                                Button(action: {
                                    set_cat(cat)
                                }, label: {Label(cat.readable_string, systemImage: cat == filteredCategory ? "checkmark" : "none")})
                            })
                        } label: {
                            Label(filteredCategory?.rawValue ?? "Category", systemImage: "chevron.down")
                                .lineLimit(1)
                                .font(.subheadline)
                                .background(UIDevice.current.userInterfaceIdiom == .phone ? .white: Color(.init(gray: 0.1, alpha: 0.0)))
                                .cornerRadius(4)
                        }
                        Menu {
                            ForEach(Landmark.Characteristic.allCases, content: { cat in
                                Button(action: {
                                    set_char(cat)
                                }, label: {Label(cat.readable_string, systemImage: cat == filteredCharacteristic ? "checkmark" : "none")})
                            })
                        } label: {
                            Label(filteredCharacteristic?.rawValue ?? "Characteristic", systemImage: "chevron.down")
                                .lineLimit(1)
                                .font(.subheadline)
                                .background(UIDevice.current.userInterfaceIdiom == .phone ? .white: Color(.init(gray: 0.1, alpha: 0.0)))
                                .cornerRadius(4)
                        }
                    }

                    ForEach(filteredLandmarks) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
                .navigationTitle("Things to Do")
                .navigationViewStyle(.columns)
                LandmarkDetail(landmark: modelData.names2landmark(names: ["World War I Museum"])[0])
            }
        } else {
            NavigationView {
                List {
                    //HStack {
                    TextField("Search", text: $search)
                    Toggle("Favorites Only", isOn: $showFavoritesOnly)
                    if let _ = modelData.w {
                        Toggle("Weather-Based", isOn: $weatherOnly)
                    }
                    //}
                    HStack {
                        Menu {
                            ForEach(Landmark.Category.allCases, content: { cat in
                                Button(action: {
                                    set_cat(cat)
                                }, label: {Label(cat.readable_string, systemImage: cat == filteredCategory ? "checkmark" : "none")})
                            })
                        } label: {
                            Label(filteredCategory?.rawValue ?? "Category", systemImage: "chevron.down")
                                .lineLimit(1)
                                .font(.subheadline)
                                .background(UIDevice.current.userInterfaceIdiom == .phone ? .white: Color(.init(gray: 0.1, alpha: 0.0)))
                                .cornerRadius(4)
                        }
                        Menu {
                            ForEach(Landmark.Characteristic.allCases, content: { cat in
                                Button(action: {
                                    set_char(cat)
                                }, label: {Label(cat.readable_string, systemImage: cat == filteredCharacteristic ? "checkmark" : "none")})
                            })
                        } label: {
                            Label(filteredCharacteristic?.rawValue ?? "Characteristic", systemImage: "chevron.down")
                                .lineLimit(1)
                                .font(.subheadline)
                                .background(UIDevice.current.userInterfaceIdiom == .phone ? .white: Color(.init(gray: 0.1, alpha: 0.0)))
                                .cornerRadius(4)
                        }
                    }

                    ForEach(filteredLandmarks) { landmark in
                        LandmarkRow(landmark: landmark)
                            .environmentObject(modelData)
                    }
                }
                .navigationTitle("Things to Do")
                .navigationViewStyle(.columns)
                .onAppear() {
                    withAnimation(.easeInOut) {
                        modelData.shown = ""
                    }
                }
                LandmarkDetail(landmark: modelData.names2landmark(names: ["World War I Museum"])[0])
            }
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
