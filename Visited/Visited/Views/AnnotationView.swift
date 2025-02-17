//
//  AnnotationView.swift
//  Visited
//
//  Created by Furkan Tekin on 17.02.2025.
//

import SwiftUI

struct AnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.accent)
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    AnnotationView()
}
