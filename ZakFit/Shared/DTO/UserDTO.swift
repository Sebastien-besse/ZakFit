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
    var genre: String
    var height: Int
    var weight: Int
    var objectif: String
    var diet: String
    var dateOfBirth: String // format ISO8601 "YYYY-MM-DD"
}

struct UserResponseDTO: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    var genre: String
    var height: Int
    var weight: Int
    var objectif: String
    var diet: String
    var dateOfBirth: String
}

