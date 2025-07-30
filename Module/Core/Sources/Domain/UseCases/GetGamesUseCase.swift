//
//  GetGamesUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

public protocol GetGamesUseCase {
    func execute() -> AnyPublisher<[Game], Error>
}

public class DefaultGetGamesUseCase: GetGamesUseCase {
    private let gameRepository: GameRepository

    public init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }

    public func execute() -> AnyPublisher<[Game], Error> {
        return gameRepository.getGames()
    }
}
