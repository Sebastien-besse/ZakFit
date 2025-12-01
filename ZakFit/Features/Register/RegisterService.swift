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

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(UserResponseDTO.self, from: data)
    }

}
