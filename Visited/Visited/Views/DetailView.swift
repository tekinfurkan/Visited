//
//  DetailView.swift
//  Visited
//
//  Created by Furkan Tekin on 17.02.2025.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @EnvironmentObject private var viewModel: LocationViewModel
    
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                ImageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    fixedMapView
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

extension DetailView {
    private var ImageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on wikipeadia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    private var fixedMapView: some View {
        Map(position: $viewModel.mapPosition) {
            ForEach(viewModel.locations) { location in
                if location == self.location {
                    Annotation("Annotations", coordinate: location.coordinates) {
                        AnnotationView()
                            .shadow(radius: 10)
                    }
                }
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1.0, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
