//
//  GameListViewModel.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation
import Combine
import SwiftUI
import Core

public class GameListViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let getGamesUseCase: GetGamesUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(getGamesUseCase: GetGamesUseCase) {
        self.getGamesUseCase = getGamesUseCase
    }

    func fetchGames() {
        isLoading = true
        errorMessage = nil

        getGamesUseCase.execute()
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching games: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] games in
                self?.games = games
            }
            .store(in: &cancellables)
    }
}
