//
//  UserDTO.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation

struct UserLoginDTO: Codable{
    var email: String
    var password: String
}

struct UserRequestDTO: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    var gender: String
    var height: Int
    var weight: Int
    var objectifHealth: String
    var diet: String
    var dateOfBirth: String
}

struct UserResponseDTO: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var gender: String
    var height: Int
    var weight: Int
    var objectifHealth: String
    var diet: String
    var dateOfBirth: String
}

