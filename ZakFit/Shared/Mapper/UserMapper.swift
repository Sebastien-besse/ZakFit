//
//  UserMapper.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import Foundation

struct UserMapper{
    func mapToUserLogin(_ register: AuthModel) -> UserLoginDTO{
        UserLoginDTO(
            email: register.email,
            password: register.password)
    }
}
