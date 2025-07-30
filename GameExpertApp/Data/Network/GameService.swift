//
//  GameService.swift
//  Game App
//
//  Created by Denny Octavian on 28/07/25.
//

import Foundation
import Combine

class APIGameService: GameRepository {
    private let apiKey = "07b93b996cf94082bca10832e835597d"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getGames() -> AnyPublisher<[Game], Error> {
        guard let url = URL(string: "https://api.rawg.io/api/games?key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: GameResponseDTO.self, decoder: JSONDecoder())
            .map { GameMapper.mapGameDTOsToDomain($0.results) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(slug: String) -> AnyPublisher<GameDetail, Error> {
        print("https://api.rawg.io/api/games/\(slug)?key=\(apiKey)")
        guard let url = URL(string: "https://api.rawg.io/api/games/\(slug)?key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: GameDetailDTO.self, decoder: JSONDecoder())
            .map { GameDetailMapper.mapGameDetailDTOToDomain($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
