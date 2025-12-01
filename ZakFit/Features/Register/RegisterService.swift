//
//  RegisterService.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import Foundation

struct RegisterService{
    
    
    func register(req: UserRequestDTO) async throws -> UserResponseDTO {
        let url = APIService.shared.baseURL.appendingPathComponent("/users/create")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(req)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                print("❌ HTTP STATUS :", http.statusCode)
                print("❌ RESPONSE :", String(data: data, encoding: .utf8) ?? "no body")
                throw URLError(.badServerResponse)
            }

            return try JSONDecoder().decode(UserResponseDTO.self, from: data)

        } catch {
            print("❌ RegisterService ERROR :", error)
            throw error
        }

    }

}
