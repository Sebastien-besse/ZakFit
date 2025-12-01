//
//  APIService.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation

class APIService{
    
    static let shared = APIService()
    let baseURL = URL(string: "http://127.0.0.1:8080")!
    
        // URLSession configurée pour le réseau local
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()
    
    init() {
#if DEBUG
        print("🌐 Base URL configurée : \(baseURL)")
#endif
    }
        // Configuration des encoders/decoders pour gérer les dates de Vapor (format ISO8601) vers Swift (format timestamp)
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    enum TVShowError: Error{
        case httpResponseError
        case decodeError
        case dataEmpty
        case urlSessionError
    }
    
        // Get avec le token user
    func getToken<T: Decodable>(endpoint: String, token: String, as type: T.Type) async throws -> T {
            // Vérifie que l'URL est correcte
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
            // Effectue la requête
        let (data, response) = try await urlSession.data(for: request)
        
            // Vérifie la réponse HTTP
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
            //  Vérifie le code HTTP et revoie une erreur correspondante
        switch httpResponse.statusCode {
            case 200:
                return try JSONDecoder().decode(T.self, from: data)
            case 400:
                throw NSError(domain: "APIError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Requête invalide (400)"])
            case 401:
                throw NSError(domain: "APIError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Non autorisé — token invalide ou expiré"])
            case 403:
                throw NSError(domain: "APIError", code: 403, userInfo: [NSLocalizedDescriptionKey: "Accès refusé (403)"])
            case 404:
                throw NSError(domain: "APIError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Ressource non trouvée (404)"])
            case 500...599:
                throw NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Erreur serveur (\(httpResponse.statusCode))"])
            default:
                throw NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Erreur inconnue (\(httpResponse.statusCode))"])
        }
    }

    
    func post<T:Decodable, U:Encodable>(endpoint: String, token: String, isLoginOrCreateUser: Bool,  body: U) async throws -> T{
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try jsonEncoder.encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if !isLoginOrCreateUser{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let (data, _) = try await urlSession.data(for: request)
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    func put<T: Decodable, U: Encodable>(endpoint: String, body: U) async throws -> T {
        let url = URL(string: "\(baseURL)/\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try jsonEncoder.encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await urlSession.data(for: request)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func patch<T: Decodable, U: Encodable>(endpoint: String, token: String, body: U) async throws -> T {
        let url = URL(string: "\(baseURL)/\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.httpBody = try jsonEncoder.encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await urlSession.data(for: request)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    
    func delete<T: Decodable>(endpoint: String, as type: T.Type = T.self) async throws -> T {
        let url = URL(string:"\(baseURL)/\(endpoint)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw TVShowError.httpResponseError
        }
        
            // Si pas de contenu (204 No Content), retourne un objet vide
        if data.isEmpty {
            return try JSONDecoder().decode(T.self, from: "{}".data(using: .utf8)!)
        }
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
}
