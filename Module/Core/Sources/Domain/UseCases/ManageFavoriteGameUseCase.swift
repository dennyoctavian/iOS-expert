//
//  ManageFavoriteGameUseCase.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Combine
import Foundation
import Core

public protocol ManageFavoriteGameUseCase {
    func executeAddFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func executeRemoveFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error>
    func executeIsFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Bool, Error>
    func executeGetFavoriteGames() -> AnyPublisher<[Game], Error>
}

public class DefaultManageFavoriteGameUseCase: ManageFavoriteGameUseCase {
    private let favoriteGameRepository: FavoriteGameRepository

    public init(favoriteGameRepository: FavoriteGameRepository) {
        self.favoriteGameRepository = favoriteGameRepository
    }

    public func executeAddFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
        return favoriteGameRepository.addFavorite(game: game)
    }

    public func executeRemoveFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
        return favoriteGameRepository.removeFavorite(game: game)
    }

    public func executeIsFavorite(game: GameProtocolForFavorites) -> AnyPublisher<Bool, Error> {
        return favoriteGameRepository.isFavorite(game: game)
    }

    public func executeGetFavoriteGames() -> AnyPublisher<[Game], Error> {
        return favoriteGameRepository.getFavoriteGames()
    }
}
