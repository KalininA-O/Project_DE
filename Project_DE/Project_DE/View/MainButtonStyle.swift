//
//  MainButtonStyle.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации кнопки с прогрессом

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    
    let disabled: Bool
    let width: CGFloat?
    let progress: Bool
    
    init(disabled: Bool = false, width: CGFloat? = nil, progress: Bool = false) {
        self.disabled = disabled
        self.width = width
        self.progress = progress
    }
    //функция состояния кнопки
    func makeBody(configuration: Configuration) -> some View {
        if progress {
            ProgressView()
                .tint(Color.white)
                .font(.custom("Roboto Black", size: 14))
                .foregroundStyle(Color.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .frame(width: width)
                .background(disabled ? Color.gray : configuration.isPressed ? Color.accentColor.opacity(0.6) : Color.accentColor)
                .clipShape(.rect(cornerRadius: 5))
        } else {
            configuration.label
                .font(.custom("Roboto Black", size: 14))
                .foregroundStyle(Color.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .frame(width: width)
                .background(disabled ? Color.gray : configuration.isPressed ? Color.accentColor.opacity(0.6) : Color.accentColor)
                .clipShape(.rect(cornerRadius: 5))
        }
    }
}

#Preview {
    Button("title123") {
        
    }
    .buttonStyle(MainButtonStyle())
    .padding()
}
