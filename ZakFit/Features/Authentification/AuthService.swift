//
//  AuthService.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation

struct AuthService {

    func login(user: UserLoginDTO) async throws -> String {

        let url = APIService.shared.baseURL.appendingPathComponent("/users/login")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(user)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        guard let token = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeRawData)
        }

        return token.replacingOccurrences(of: "\"", with: "")
    }
}
