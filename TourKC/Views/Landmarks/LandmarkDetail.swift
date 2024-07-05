/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI
import MapKit

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView { //Allows user to scroll
            MapView(coordinate: landmark.locationCoordinate)//Mapview 
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image) //Circle Image of the Attraction
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    // Set attractions name next to favortie button 
                    Text(landmark.name)
                        .font(.title) 
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite, name: landmark.name)
                }

                HStack {
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(landmark.name)") //Layout with name
                    .font(.title2)
                //Description, website, and similare attractions reccomendation
                Text(.init("\(landmark.description) To learn more about \(landmark.name), visit their website [here](\(landmark.website))."))
                if (landmark.like.count > 0) {
                    Text("\n")
                    Text("You Might Also Like")
                        .font(.title2)
                    // Interacts with Kmeans clustering algorithm to show similar locations
                    ForEach(modelData.names2landmark(names: landmark.like)) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark, defNav: true)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(landmark.name) //Sets title as name
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
