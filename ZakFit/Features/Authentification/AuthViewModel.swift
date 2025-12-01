//
//  AuthViewModel.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation

@MainActor
@Observable
class AuthViewModel{
     var email = ""
     var password = ""
     var token: String?
     var errorMessage: String?
     var isAuth = false

    func login() async {
        isAuth = true
        errorMessage = nil

        let dto = UserLoginDTO(email: email, password: password)

        do {
            let token = try await AuthService().login(user: dto)
            self.token = token
            print("TOKEN =", token)

        } catch {
            self.errorMessage = "Email ou mot de passe incorrect"
            print("API ERROR:", error)
        }

        isAuth = false
    }
}
