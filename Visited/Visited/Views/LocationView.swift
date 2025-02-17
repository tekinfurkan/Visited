//
//  LocationView.swift
//  Visited
//
//  Created by Furkan Tekin on 13.02.2025.
//

import SwiftUI
import MapKit
import Foundation

struct LocationView: View {
    @EnvironmentObject var viewModel: LocationViewModel
    @State var showSheet: Bool = false

    var body: some View {
        ZStack {
            mapLayer
            VStack {
                header
                    .padding()
                Spacer()
                locationsCardPreviewStack
            }
        }
    }
}

extension LocationView {
    private var header: some View {
        VStack {
            Button {
                withAnimation {
                    viewModel.isShowingLocationList.toggle()

                }
                } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(Color.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(Color.black)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.isShowingLocationList ? 180 : 0))
                    }
            }

            if viewModel.isShowingLocationList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .sheet(isPresented: $showSheet) {
            DetailView(location: viewModel.mapLocation)
        }
    }
    private var mapLayer: some View {
        Map(position: $viewModel.mapPosition) {
            ForEach(viewModel.locations) { location in
                Annotation("Annotations", coordinate: location.coordinates) {
                    AnnotationView()
                        .scaleEffect(location == viewModel.mapLocation ? 1.5 : 0.9)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showSelectedLocation(location: location)
                        }
                }
            }
        }
    }
    private var locationsCardPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationCardPreview(location: location, showSheet: $showSheet)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}



#Preview {
    @Previewable @StateObject var vm = LocationViewModel()
    LocationView()
        .environmentObject(vm)
}
