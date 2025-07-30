//
//  GameDetailViewModel.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//
import Foundation
import Combine
import SwiftUI
import Core

public class GameDetailViewModel: ObservableObject {
    @Published var gameDetail: GameDetail?
    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let gameSlug: String
    private let getGameDetailUseCase: GetGameDetailUseCase
    private let manageFavoriteGameUseCase: ManageFavoriteGameUseCase
    private var cancellables = Set<AnyCancellable>()

    init(gameSlug: String, getGameDetailUseCase: GetGameDetailUseCase, manageFavoriteGameUseCase: ManageFavoriteGameUseCase) {
        self.gameSlug = gameSlug
        self.getGameDetailUseCase = getGameDetailUseCase
        self.manageFavoriteGameUseCase = manageFavoriteGameUseCase
        
        fetchGameDetail()
    }

    func fetchGameDetail() {
        isLoading = true
        errorMessage = nil

        getGameDetailUseCase.execute(slug: gameSlug)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching game detail: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] detail in
                self?.gameDetail = detail
                if let loadedGame = self?.gameDetail {
                    self?.checkFavoriteStatus(for: loadedGame)
                }
            }
            .store(in: &cancellables)
    }

    func checkFavoriteStatus(for game: GameProtocolForFavorites) {
        manageFavoriteGameUseCase.executeIsFavorite(game: game)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] isFav in
                self?.isFavorite = isFav
            }
            .store(in: &self.cancellables)
    }

    func toggleFavorite() {
        guard let game = gameDetail else {
            print("Cannot toggle favorite: gameDetail is nil.")
            return
        }

        if isFavorite {
            manageFavoriteGameUseCase.executeRemoveFavorite(game: game)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    } else {
                        self?.isFavorite = false
                    }
                } receiveValue: { _ in }
                .store(in: &self.cancellables)
        } else {
            manageFavoriteGameUseCase.executeAddFavorite(game: game)
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    } else {
                        self?.isFavorite = true
                    }
                } receiveValue: { _ in }
                .store(in: &self.cancellables)
        }
    }
}
