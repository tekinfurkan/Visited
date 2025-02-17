//
//  LocationsListView.swift
//  Visited
//
//  Created by Furkan Tekin on 14.02.2025.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject var viewModel: LocationViewModel
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showSelectedLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)

            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    @Previewable @StateObject var vm = LocationViewModel()
    LocationsListView()
        .environmentObject(vm)
}

extension LocationsListView {
    func listRowView(location: Location) -> some View {
        HStack {
            Image(location.imageNames.first!)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
