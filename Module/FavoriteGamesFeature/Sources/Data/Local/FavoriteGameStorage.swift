//
//  FavoriteGameStorage.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation
import Combine
import Core

public class FavoriteGameStorage: FavoriteGameRepository {
    private let userDefaults: UserDefaults
    private let favoritesKey = "favoriteGames"

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func getFavoriteGames() -> AnyPublisher<[Game], Error> {
        return Future<[Game], Error> { promise in
            if let savedGamesData = self.userDefaults.data(forKey: self.favoritesKey) {
                do {
                    let decodedGames = try JSONDecoder().decode([Game].self, from: savedGamesData)
                    promise(.success(decodedGames))
                } catch {
                    promise(.failure(error))
                }
            } else {
                promise(.success([]))
            }
        }
        .eraseToAnyPublisher()
    }

    public  func addFavorite(game favoriteGame: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
           return Future<Void, Error> { [weak self] promise in
               guard let self = self else {
                   promise(.failure(URLError(.cancelled)))
                   return
               }
               
               self.getFavoriteGames()
                   .sink(receiveCompletion: { completion in
                       if case .failure(let error) = completion {
                           promise(.failure(error))
                       }
                   }, receiveValue: { currentFavorites in
                       var newFavorites = currentFavorites
                       
                       let gameToStore = Game(
                           id: favoriteGame.id,
                           name: favoriteGame.name,
                           released: favoriteGame.released,
                           backgroundImageURL: favoriteGame.backgroundImageURL,
                           rating: favoriteGame.rating,
                           platforms: [],
                           genres: [],
                           slug: favoriteGame.slug,
                       )

                       if !newFavorites.contains(where: { $0.id == gameToStore.id }) {
                           newFavorites.append(gameToStore)
                           if let encoded = try? JSONEncoder().encode(newFavorites) {
                               self.userDefaults.set(encoded, forKey: self.favoritesKey)
                               print("Game added to favorites: \(gameToStore.name)")
                               promise(.success(()))
                           } else {
                               promise(.failure(EncodingError.invalidValue(gameToStore, EncodingError.Context(codingPath: [], debugDescription: "Failed to encode game for adding"))))
                           }
                       } else {
                           print("Game already in favorites: \(gameToStore.name)")
                           promise(.success(()))
                       }
                   })
                   .store(in: &self.cancellables)
           }
           .eraseToAnyPublisher()
       }

    public  func removeFavorite(game favoriteGame: GameProtocolForFavorites) -> AnyPublisher<Void, Error> {
           return Future<Void, Error> { [weak self] promise in
               guard let self = self else {
                   promise(.failure(URLError(.cancelled)))
                   return
               }
               self.getFavoriteGames()
                   .sink(receiveCompletion: { completion in
                       if case .failure(let error) = completion {
                           promise(.failure(error))
                       }
                   }, receiveValue: { currentFavorites in
                       var newFavorites = currentFavorites
                       let initialCount = newFavorites.count
                       newFavorites.removeAll(where: { $0.id == favoriteGame.id })
                       if newFavorites.count < initialCount {
                           if let encoded = try? JSONEncoder().encode(newFavorites) {
                               self.userDefaults.set(encoded, forKey: self.favoritesKey)
                               print("Game removed from favorites: \(favoriteGame.name)")
                               promise(.success(()))
                           } else {
                               promise(.failure(EncodingError.invalidValue(favoriteGame, EncodingError.Context(codingPath: [], debugDescription: "Failed to encode game after removal"))))
                           }
                       } else {
                           print("Game not found in favorites for removal: \(favoriteGame.name)")
                           promise(.success(()))
                       }
                   })
                   .store(in: &self.cancellables)
           }
           .eraseToAnyPublisher()
       }

    public func isFavorite(game favoriteGame: GameProtocolForFavorites) -> AnyPublisher<Bool, Error> {
           return Future<Bool, Error> { [weak self] promise in
               guard let self = self else {
                   promise(.failure(URLError(.cancelled)))
                   return
               }
               self.getFavoriteGames()
                   .sink(receiveCompletion: { completion in
                       if case .failure(let error) = completion {
                           promise(.failure(error))
                       }
                   }, receiveValue: { currentFavorites in
                       promise(.success(currentFavorites.contains(where: { $0.id == favoriteGame.id })))
                   })
                   .store(in: &self.cancellables)
           }
           .eraseToAnyPublisher()
       }

    private var cancellables = Set<AnyCancellable>()
}
