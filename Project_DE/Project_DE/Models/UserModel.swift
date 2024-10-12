//
//  UserModel.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации класса пользователей

import Foundation
struct UserModel: Codable {
    var id: UUID
    var name: String
    var phone_number: String
    var created_at: Date
}
