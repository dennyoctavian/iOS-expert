//
//  AboutView.swift
//  Game App
//
//  Created by Denny Octavian on 26/07/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: "https://media.licdn.com/dms/image/v2/D5603AQEK0uDU4aNDMw/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1728727343810?e=1756339200&v=beta&t=cUD0a6slWE31CtvA2iGeSFViHf916Zo_PzPPF7AsBY4")) { image in
                      image
                          .resizable()
                          .clipShape(Circle())
                          .frame(width: 140, height: 140)
                          .shadow(radius: 10)
                  } placeholder: {
                      ProgressView()
                  }
                  .aspectRatio(contentMode: .fit)

            Text("Denny Octavian")
                .font(.title)
                .fontWeight(.bold)

            Text("dennyoctavian164@gmail.com")
                .font(.caption)
        }
        .padding()
        .navigationTitle("Tentang Saya")
    }
}
