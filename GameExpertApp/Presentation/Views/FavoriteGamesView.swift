//
//  FavoriteGamesView.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//
import SwiftUI

struct FavoriteGamesView: View {
    @StateObject var viewModel: FavoriteGamesViewModel
    
    private let getGameDetailUseCase: GetGameDetailUseCase
    private let manageFavoriteGameUseCase: ManageFavoriteGameUseCase

    init(viewModel: FavoriteGamesViewModel, getGameDetailUseCase: GetGameDetailUseCase, manageFavoriteGameUseCase: ManageFavoriteGameUseCase) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.getGameDetailUseCase = getGameDetailUseCase
        self.manageFavoriteGameUseCase = manageFavoriteGameUseCase
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView("Loading Favorite Games...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else if viewModel.favoriteGames.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorite Games", systemImage: "heart.slash")
                    } description: {
                        Text("Add games to your favorites from the main list.")
                    }
                }
                else {
                    ForEach(viewModel.favoriteGames) { game in
                        NavigationLink(
                            destination: GameDetailView(
                                initialGame: game,
                                getGameDetailUseCase: getGameDetailUseCase,
                                manageFavoriteGameUseCase: manageFavoriteGameUseCase
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
                    .onDelete(perform: removeFavorite)
                }
            }
            .navigationTitle("Favorite Games")
            .onAppear {
                viewModel.fetchFavoriteGames()
            }
        }
    }

    private func removeFavorite(at offsets: IndexSet) {
        offsets.forEach { index in
            let gameToRemove = viewModel.favoriteGames[index]
            viewModel.removeFavorite(game: gameToRemove)
        }
    }
}
