//
//  GameDetailView.swift
//  Game App
//
//  Created by Denny Octavian on 26/07/25.
//
import SwiftUI
import Core

public struct GameDetailView: View {
    let initialGame: Game

    @StateObject var viewModel: GameDetailViewModel

    init(initialGame: Game, getGameDetailUseCase: GetGameDetailUseCase, manageFavoriteGameUseCase: ManageFavoriteGameUseCase) {
        self.initialGame = initialGame
        _viewModel = StateObject(wrappedValue: GameDetailViewModel(
            gameSlug: initialGame.slug,
            getGameDetailUseCase: getGameDetailUseCase,
            manageFavoriteGameUseCase: manageFavoriteGameUseCase
        ))
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.isLoading {
                    ProgressView("Loading game details...")
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let gameDetail = viewModel.gameDetail {
                    if let imageUrl = gameDetail.backgroundImageURL {
                                AsyncImage(url: imageUrl) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    case .failure:
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.red)
                                            .frame(height: 200)
                                    default:
                                        ProgressView()
                                            .frame(height: 200)
                                    }
                                }
                                .frame(height: 200)
                                .cornerRadius(8)
                                .clipped()
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .foregroundColor(.gray)
                                    .cornerRadius(8)
                            }

                            Text(gameDetail.name)
                                .font(.title)
                                .fontWeight(.bold)

                            HStack {
                                Text("Released: \(gameDetail.released)")
                                Spacer()
                                Text("⭐️ \(String(format: "%.1f", gameDetail.rating))")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                            Divider()

                            Text("Genres:")
                                .font(.headline)
                            Text(gameDetail.genres.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Divider()

                            Text("Available on:")
                                .font(.headline)
                            Text(gameDetail.platforms.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                } else {
                    Text("No game details available.")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
        .navigationTitle(initialGame.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                     viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

public extension DateFormatter {
    static let simpleDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
