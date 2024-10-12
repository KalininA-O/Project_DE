//
//  AuthViewModel.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Класс для реализации авторизации

import Foundation
class AuthViewModel: ObservableObject{
    
    

        @Published  var login: String = "***********@mail.com"
        @Published  var password: String = "**********"
        
        @Published  var isProgress: Bool = false
        @Published  var isNavigate: Bool = false
        @Published  var error: Bool = false
        //авторизация асинхронным методом
        func signIn(){
            Task {
                do {
                    await MainActor.run {
                        self.isProgress = true
                    }
                    try await Repositories.instance.signIn(email: login, password: password)
                    
                    await MainActor.run {
                        self.isNavigate = true
                        self.isProgress = false
                    }
                    
                    
                } catch {
                    print(error.localizedDescription)
                    await MainActor.run {
                        self.error = true
                        self.isProgress = false
                    }
                }
                
                
            }
            
            
                    }

}
