//
//  ManageFavoriteGameUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation

protocol ManageFavoriteGameUseCase {
    func executeAddFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func executeRemoveFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func executeIsFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Bool, Error>
    func executeGetFavoriteGames() -> AnyPublisher<[Game], Error>
}

class DefaultManageFavoriteGameUseCase: ManageFavoriteGameUseCase {
    private let favoriteGameRepository: FavoriteGameRepository

    init(favoriteGameRepository: FavoriteGameRepository) {
        self.favoriteGameRepository = favoriteGameRepository
    }

    func executeAddFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
        return favoriteGameRepository.addFavorite(game: game)
    }

    func executeRemoveFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
        return favoriteGameRepository.removeFavorite(game: game)
    }

    func executeIsFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Bool, Error> {
        return favoriteGameRepository.isFavorite(game: game)
    }

    func executeGetFavoriteGames() -> AnyPublisher<[Game], Error> {
        return favoriteGameRepository.getFavoriteGames()
    }
}
