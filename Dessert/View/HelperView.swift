//
//  HelperView.swift
//  Dessert
//
//  Created by Trung Nguyen on 11/9/23.
//

import SwiftUI

struct LoadAsyncImage: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Image(systemName: "x.circle")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
    }
}

struct FailedView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.red)
                .font(.largeTitle)
            Text("Opps... something went wrong")
            Button("Report") {
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}
