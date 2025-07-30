//
//  ContentView.swift
//  Game App
//
//  Created by Denny Octavian on 26/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: GameListViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView("Loading Games...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    ForEach(viewModel.games) { game in
                        NavigationLink(
                            destination:
                                GameDetailView(
                                    initialGame: game,
                                    getGameDetailUseCase: AppContainer.shared.resolve(GetGameDetailUseCase.self)!,
                                    manageFavoriteGameUseCase: AppContainer.shared.resolve(ManageFavoriteGameUseCase.self)!
                                )
                        ) {
                            HStack {
                                AsyncImage(url: game.backgroundImageURL) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else if phase.error != nil {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.gray)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 100, height: 60)
                                .cornerRadius(8)
                                .clipped()

                                VStack(alignment: .leading) {
                                    Text(game.name)
                                        .font(.headline)
                                    Text("Rating: \(String(format: "%.1f", game.rating))")
                                        .font(.subheadline)
                                    
                                    if let releasedDate = game.released {
                                        Text("Released: \(releasedDate, formatter: DateFormatter.simpleDate)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    } else {
                                        Text("Released: N/A")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Games")
            .onAppear {
                if viewModel.games.isEmpty {
                    viewModel.fetchGames()
                }
            }
            .navigationTitle("Popular Games")
            .toolbar {
                NavigationLink("About", destination: AboutView())
            }
        }
    }
}
