//
//  ProfilService.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation

class ProfileService {
    
    static let shared = ProfileService()
    private init() {}

    // Récupération du profil
    func fetchProfile(token: String) async throws -> UserResponseDTO {
        return try await APIService.shared.getToken(
            endpoint: "/users/profil",
            token: token,
            as: UserResponseDTO.self
        )
    }
    
    // Mise à jour du profil
    func updateProfile(token: String, user: UserResponseDTO) async throws -> UserResponseDTO {
        return try await APIService.shared.post(
            endpoint: "/users/update",
            token: token,
            isLoginOrCreateUser: false,
            body: user
        )
    }
}
