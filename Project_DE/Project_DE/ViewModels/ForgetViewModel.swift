//
//  ForgetViewModel.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Класс для реализации отправки на почту токена

import Foundation
class ForgetViewModel: ObservableObject{
    
    

        @Published  var email: String = "***********@mail.com"
        
        @Published  var isProgress: Bool = false
        @Published var isNavigate: Bool = false
        @Published  var error: Bool = false
        //отправка токена на почту асинхронным методом
        func send(){
            Task {
                do {
                    await MainActor.run {
                        self.isProgress = true
                    }
                    try await Repositories.instance.resetPasword(email: email)
                    
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

