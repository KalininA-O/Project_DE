//
//  NewPassViewModel.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Класс для реализации изменения пароля

import Foundation
class NewPassViewModel: ObservableObject{
    
    

        @Published  var password: String = "******"
        
        @Published  var isProgress: Bool = false
        @Published var isNavigate: Bool = false
        @Published  var error: Bool = false
        //изменение пароля асинхронным методом
        func newpassword() {
            Task {
                do {
                    await MainActor.run {
                        self.isProgress = true
                    }
                    try await Repositories.instance.setNewPassword(passowrd: password)
                    
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
