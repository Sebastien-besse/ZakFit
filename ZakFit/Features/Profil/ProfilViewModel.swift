//
//  ProfilViewModel.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    
    var user: UserResponseDTO?
    var isLoading = false
    var errorMessage: String?
    
    private let service = ProfileService.shared
    
    func loadProfile(token: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await service.fetchProfile(token: token)
            self.user = data
        } catch {
            print("PROFILE ERROR:", error)
            errorMessage = "Impossible de charger le profil"
        }
        
        isLoading = false
    }
    
    func updateProfile(token: String) async {
        guard let user = user else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let updatedUser = try await service.updateProfile(token: token, user: user)
            self.user = updatedUser
        } catch {
            print("UPDATE ERROR:", error)
            errorMessage = "Impossible de mettre à jour"
        }
        
        isLoading = false
    }
}




