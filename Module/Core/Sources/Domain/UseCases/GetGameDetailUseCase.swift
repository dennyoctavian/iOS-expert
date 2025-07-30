//
//  GetGameDetailUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation
import Core

public protocol GetGameDetailUseCase {
    func execute(slug: String) -> AnyPublisher<GameDetail, Error>
}

public class DefaultGetGameDetailUseCase: GetGameDetailUseCase {
    private let gameRepository: GameRepository


    public init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }

   public func execute(slug: String) -> AnyPublisher<GameDetail, Error> {
        return gameRepository.getGameDetail(slug: slug)
    }
}
