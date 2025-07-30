//
//  AppContainer.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//
// Corrected AppContainer.swift
import Foundation

class AppContainer {
    static let shared = AppContainer()

    private var dependencies: [String: Any] = [:]

    private init() {
        registerDependencies()
    }

    func register<T>(_ type: T.Type, _ instance: Any) {
        let key = String(describing: type)
        dependencies[key] = instance
    }

    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return dependencies[key] as? T
    }

    private func registerDependencies() {
        register(GameRepository.self, APIGameService())
        
        register(FavoriteGameRepository.self, FavoriteGameStorage())
        
        if let gameRepo = resolve(GameRepository.self) {
            register(GetGamesUseCase.self, DefaultGetGamesUseCase(gameRepository: gameRepo))
        }

        if let gameRepo = resolve(GameRepository.self) {
            register(GetGameDetailUseCase.self, DefaultGetGameDetailUseCase(gameRepository: gameRepo))
        }

        if let favRepo = resolve(FavoriteGameRepository.self) {
            register(ManageFavoriteGameUseCase.self, DefaultManageFavoriteGameUseCase(favoriteGameRepository: favRepo))
        }

        if let manageFavUC = resolve(ManageFavoriteGameUseCase.self) {
            register(FavoriteGamesViewModel.self, FavoriteGamesViewModel(manageFavoriteGameUseCase: manageFavUC))
        }
    }
}
