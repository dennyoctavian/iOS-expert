//
//  GetGameDetailUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

protocol GetGameDetailUseCase {
    func execute(slug: String) -> AnyPublisher<GameDetail, Error>
}

class DefaultGetGameDetailUseCase: GetGameDetailUseCase {
    private let gameRepository: GameRepository


    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }

    func execute(slug: String) -> AnyPublisher<GameDetail, Error> {
        return gameRepository.getGameDetail(slug: slug)
    }
}
