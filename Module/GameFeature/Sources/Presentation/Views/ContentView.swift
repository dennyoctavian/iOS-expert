//
//  ContentView.swift
//  Game App
//
//  Created by Denny Octavian on 26/07/25.
//

import SwiftUI
import Core
import GameDetailFeature

public struct ContentView: View {
    @StateObject var viewModel: GameListViewModel
    private let getGameDetailUseCase: GetGameDetailUseCase
    private let manageFavoriteGameUseCase: ManageFavoriteGameUseCase
    
    public init(viewModel: GameListViewModel,
                getGameDetailUseCase: GetGameDetailUseCase,
                manageFavoriteGameUseCase: ManageFavoriteGameUseCase
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.getGameDetailUseCase = getGameDetailUseCase
        self.manageFavoriteGameUseCase = manageFavoriteGameUseCase
    }

    public var body: some View {
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
                                    getGameDetailUseCase: self.getGameDetailUseCase,
                                    manageFavoriteGameUseCase: self.manageFavoriteGameUseCase
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
        }
    }
}
