//
//  Forgot.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации отправки на почту токена для изменения пароля

import SwiftUI

struct Forgot: View {
    @State private var NavigationOTP: Bool = false
    @State private var showingAlert = false
    @StateObject var forgetViewModel = ForgetViewModel()
    @State var changeEmail:Bool=false
    var body: some View {
        NavigationView{
            
            VStack{
                //навигация
                NavigationLink(destination: OTPview(forgetViewModel: forgetViewModel), isActive: $forgetViewModel.isNavigate)
                {EmptyView()}
                HStack{
                    Text("Forgot Password")
                        .padding(.leading, 10)
                    
                        .font(.custom("Roboto-black",size:20))
                    
                    
                    Spacer()
                }
                HStack{
                    Text("Enter your email address")
                        .padding(.leading, 10)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .font(.custom("Roboto-black",size:10))
                    Spacer()
                }
                HStack{
                    Text("Email Address")
                        .padding(.leading,10)
                        .padding(.top,50)
                        .foregroundColor(.gray)
                        .font(.custom("Roboto-black",size:10))
                    Spacer()
                }
                HStack{
                    TextField("login", text: $forgetViewModel.email, onEditingChanged: {change in changeEmail = true})
                        .foregroundColor(.gray)
                        .font(.custom("Roboto-black",size:10))
                        .opacity(0.5)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading,10)
                        .cornerRadius(10)
                    Spacer()
                    
                }
                HStack{
                    //проверка состояния
                    if(changeEmail)
                    {
                        Button(action:{
                                //отправка токена на почту
                                forgetViewModel.send()
                                
                            
                        }){
                            Text("Send OTP")
                            
                        }
                        .background(Color.blun)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(10)
                        .alert(isPresented: $forgetViewModel.error) {
                                    Alert(title: Text("Error"),
                                          message: Text("Incorrect login"),
                                          dismissButton: .default(Text("OK")))
                                }
                        .buttonStyle(MainButtonStyle(progress: forgetViewModel.isProgress))

                    }
                    else{
                        Button(action:{}){
                            Text("Send OTP")
                            
                        }
                        .frame(width: 350, height: 30)
                        .font(.custom("Roboto-black",size:14))
                        .padding(10)
                        .background(Color.gr)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                    
                }.padding(.top,40)
                HStack{
                    ZStack{
                        
                        Text("Remember password? Back to                               ")
                        
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        
                        NavigationLink("                                       Sign in", destination: Login())
                            .foregroundColor(.blun)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                }.padding(10)
            }
        }.navigationBarBackButtonHidden()
    }

}

#Preview {
    Forgot()
}
