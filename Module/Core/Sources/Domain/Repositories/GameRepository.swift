//
//  GameRepository.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

public protocol GameRepository {
    func getGames() -> AnyPublisher<[Game], Error>
    func getGameDetail(slug: String) -> AnyPublisher<GameDetail, Error>
}
