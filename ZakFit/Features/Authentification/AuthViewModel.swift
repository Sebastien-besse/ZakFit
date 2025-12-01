//
//  AuthViewModel.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class AuthViewModel {
    var email = ""
    var password = ""
    var token: String?
    var errorMessage: String?
    var isAuth = false

    func login() async {
        errorMessage = nil

        let dto = UserLoginDTO(email: email, password: password)

        do {
            let token = try await AuthService().login(user: dto)
            self.token = token
            print("TOKEN =", token)

            // MAJ de l'état de connexion
            self.isAuth = true

        } catch {
            self.errorMessage = "Email ou mot de passe incorrect"
            print("API ERROR:", error)
            self.isAuth = false
        }
    }
    
    func logout() {
           token = nil
           isAuth = false
           email = ""
           password = ""
       }
}



//@MainActor
//@Observable
//class AuthViewModel {
//    var email = ""
//    var password = ""
//    var token: String?
//    var errorMessage: String?
//    var isAuth = false
//    var isLoading = false
//    
//    private let tokenKey = "userToken"
//    
//    init() {
//        // Vérifier si un token existe déjà au démarrage
//        checkExistingToken()
//    }
//    
//    func login() async {
//        errorMessage = nil
//        isLoading = true
//        
//        // Validation basique
//        guard !email.isEmpty, !password.isEmpty else {
//            errorMessage = "Veuillez remplir tous les champs"
//            isLoading = false
//            return
//        }
//        
//        let dto = UserLoginDTO(email: email, password: password)
//        
//        do {
//            let token = try await AuthService().login(user: dto)
//            self.token = token
//            
//            // Sauvegarder le token dans UserDefaults (ou mieux, dans le Keychain)
//            UserDefaults.standard.set(token, forKey: tokenKey)
//            
//            print("✅ TOKEN =", token)
//            
//            // MAJ de l'état de connexion
//            self.isAuth = true
//            isLoading = false
//            
//        } catch let error as URLError {
//            handleURLError(error)
//            self.isAuth = false
//            isLoading = false
//        } catch {
//            self.errorMessage = "Email ou mot de passe incorrect"
//            print("❌ API ERROR:", error)
//            self.isAuth = false
//            isLoading = false
//        }
//    }
//    
//    func logout() {
//        // Supprimer le token
//        UserDefaults.standard.removeObject(forKey: tokenKey)
//        
//        // Réinitialiser les données
//        self.token = nil
//        self.email = ""
//        self.password = ""
//        self.isAuth = false
//        self.errorMessage = nil
//    }
//    
//    private func checkExistingToken() {
//        if let savedToken = UserDefaults.standard.string(forKey: tokenKey) {
//            self.token = savedToken
//            self.isAuth = true
//            print("✅ Token existant trouvé")
//        }
//    }
//    
//    private func handleURLError(_ error: URLError) {
//        switch error.code {
//        case .badServerResponse:
//            errorMessage = "Email ou mot de passe incorrect"
//        case .notConnectedToInternet:
//            errorMessage = "Pas de connexion Internet"
//        case .timedOut:
//            errorMessage = "Délai de connexion dépassé"
//        default:
//            errorMessage = "Une erreur s'est produite"
//        }
//    }
//}
