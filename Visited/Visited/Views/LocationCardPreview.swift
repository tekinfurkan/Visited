//
//  LocationCardPreview.swift
//  Visited
//
//  Created by Furkan Tekin on 16.02.2025.
//

import SwiftUI

struct LocationCardPreview: View {
    @EnvironmentObject var vm: LocationViewModel
    let location: Location
    @Binding var showSheet: Bool
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                ImageSection
                titleSection
            }
            VStack(spacing: 8.0) {
                LearnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension LocationCardPreview {
    private var ImageSection: some View {
        ZStack {
            Image(location.imageNames.first!)
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(6)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    private var titleSection: some View {
        VStack(alignment: .leading , spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth:.infinity, alignment: .leading)
    }
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width:125,height: 35)
        }
        .buttonStyle(.bordered)
    }
    private var LearnMoreButton: some View {
        Button {
            showSheet.toggle()
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width:125,height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
}
