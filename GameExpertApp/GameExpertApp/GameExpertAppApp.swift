//
//  GameExpertAppApp.swift
//  GameExpertApp
//
//  Created by Denny Octavian on 28/07/25.
//

import SwiftUI
import Core
import GameDetailFeature
import FavoriteGamesFeature
import GameFeature
import Networking

@main
struct GameExpertAppApp: App {
    private let appContainer = AppContainer.shared

        var body: some Scene {
            WindowGroup {
                if let getGamesUseCase = appContainer.resolve(GetGamesUseCase.self),
                   let manageFavoriteGameUseCase = appContainer.resolve(ManageFavoriteGameUseCase.self),
                   let favoriteGamesViewModel = appContainer.resolve(FavoriteGamesViewModel.self),
                   let getGameDetailUseCase = appContainer.resolve(GetGameDetailUseCase.self)
                {
                    TabView {
                        ContentView(
                            viewModel: GameListViewModel(
                                getGamesUseCase: getGamesUseCase,
                            ),
                            getGameDetailUseCase: getGameDetailUseCase,
                            manageFavoriteGameUseCase: manageFavoriteGameUseCase
                        )
                        .tabItem {
                            Label("Games", systemImage: "gamecontroller.fill")
                        }

                        FavoriteGamesView(
                            viewModel: favoriteGamesViewModel,
                            getGameDetailUseCase: getGameDetailUseCase,
                            manageFavoriteGameUseCase: manageFavoriteGameUseCase
                        )
                        .tabItem {
                            Label("Favorites", systemImage: "heart.fill")
                        }
                        AboutView()
                            .tabItem {
                                Label("About", systemImage: "person.fill")
                            }
                    }
                } else {
                    Text("Error: Application dependencies could not be resolved.")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
}
