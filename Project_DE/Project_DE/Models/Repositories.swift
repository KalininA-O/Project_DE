//
//  Repositories.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации класса репозитория

import Foundation
import Supabase

class Repositories {
    // паттерн instance
    static let instance = Repositories()

    // подключение supabase
    let supabase = SupabaseClient(
        supabaseURL: URL(string: "https://lmguufreweykcuupwdhh.supabase.co")!,
        supabaseKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxtZ3V1ZnJld2V5a2N1dXB3ZGhoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0Mzg4MDksImV4cCI6MjA0NDAxNDgwOX0.YC4pJqQxFaQz2NhfZimEwo0rATUWZWwzNfI8nt59wX4",
        options: .init())
    
    func signUp(name: String, phone_number: String, email: String, password: String) async throws {
            try await supabase.auth.signUp(email: email, password: password)
            
            let user = try await supabase.auth.session.user
            
            let newUser = UserModel(id: user.id, name: name, phone_number: phone_number, created_at: .now)
            
            try await supabase.from("users")
                .insert(newUser)
                .execute()
            
            try await supabase.auth.signOut()
        }
    // вход в supabase
    func signIn(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }
    // проверка кода в supabase
    func sendOTP(email: String, code: String) async throws {
        try await supabase.auth.verifyOTP(email: email, token: code, type: .recovery)
    }
    // сброс пароля в supabase (отправка кода на почту)
    func resetPasword(email: String) async throws {
        try await supabase.auth.resetPasswordForEmail(email)
    }
    // установка нового пароля в supabase
    func setNewPassword(passowrd: String) async throws {
        try await supabase.auth.update(user: .init(password: passowrd))
    }

    
    }
