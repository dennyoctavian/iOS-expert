//
//  FavoriteGameRepository.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

protocol FavoriteGameRepository {
    func getFavoriteGames() -> AnyPublisher<[Game], Error>
    func addFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func removeFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func isFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Bool, Error>
}
