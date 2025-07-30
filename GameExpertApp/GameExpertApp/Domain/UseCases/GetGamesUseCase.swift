//
//  GetGamesUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

protocol GetGamesUseCase {
    func execute() -> AnyPublisher<[Game], Error>
}

class DefaultGetGamesUseCase: GetGamesUseCase {
    private let gameRepository: GameRepository

    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }

    func execute() -> AnyPublisher<[Game], Error> {
        return gameRepository.getGames()
    }
}
