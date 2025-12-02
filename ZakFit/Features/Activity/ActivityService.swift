//
//  ActivityService.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation

@MainActor
class ActivityService {
    static let shared = ActivityService()
    private init() {}

    func createActivity(dto: ActivityCreateDTO, token: String) async throws -> ActivityDTO {
        try await APIService.shared.post(endpoint: "/activity/create", token: token, isLoginOrCreateUser: false, body: dto)
    }

    func getActivities(token: String) async throws -> [ActivityDTO] {
        try await APIService.shared.getToken(endpoint: "/activity/activities", token: token, as: [ActivityDTO].self)
    }

    func updateActivity(id: UUID, dto: ActivityUpdateDTO, token: String) async throws -> ActivityDTO {
        try await APIService.shared.put(endpoint: "activity/update/\(id)", body: dto)
    }

    func deleteActivity(id: UUID, token: String) async throws {
        _ = try await APIService.shared.delete(endpoint: "activity/delete/\(id)", as: EmptyResponse.self)
    }
}

// Pour la gestion des réponses vides
struct EmptyResponse: Codable {}
