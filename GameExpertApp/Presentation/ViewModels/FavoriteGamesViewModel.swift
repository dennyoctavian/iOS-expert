//
//  FavoriteGamesViewModel.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation
import Combine
import SwiftUI

class FavoriteGamesViewModel: ObservableObject {
    @Published var favoriteGames: [Game] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let manageFavoriteGameUseCase: ManageFavoriteGameUseCase
    private var cancellables = Set<AnyCancellable>()

    init(manageFavoriteGameUseCase: ManageFavoriteGameUseCase) {
        self.manageFavoriteGameUseCase = manageFavoriteGameUseCase
    }

    func fetchFavoriteGames() {
        isLoading = true
        errorMessage = nil

        manageFavoriteGameUseCase.executeGetFavoriteGames()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching favorite games: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] games in
                self?.favoriteGames = games
            }
            .store(in: &cancellables)
    }

    func removeFavorite(game: Game) {
        manageFavoriteGameUseCase.executeRemoveFavorite(game: game)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error removing favorite: \(error.localizedDescription)")
                case .finished:
                    self.fetchFavoriteGames()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
