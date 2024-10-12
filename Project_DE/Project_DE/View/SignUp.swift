//
//  SignUp.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации создания нового пользователя

import SwiftUI

import Foundation

struct SignUp: View {
    @StateObject var userViewModel = UserViewModel()
    @State private var showingAlert = false
    @State private var NavigationHome: Bool = false
    @State private var checkBox: Bool = false
    @State var img: String = "eye.slash"
    @State var imgg: String = "eye.slash"
    @State var col: Color = Color.blun
    @State var bol:Bool=true
    @State var boll:Bool=true
    var body: some View {
        NavigationView{
            ZStack{
                //навигация
                NavigationLink(destination: Home(), isActive: $userViewModel.isNavigate)
                {EmptyView()}
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    HStack{
                        Text("Create an account")
                            .padding(.leading, 10)
                        
                            .font(.custom("Roboto-black",size:20))
                            .alert(isPresented: $userViewModel.error) {
                                        Alert(title: Text("Error"),
                                              message: Text("Invalid input"),
                                              dismissButton: .default(Text("OK")))
                                    }
                        
                        Spacer()
                    }
                    HStack{
                        Text("Complete the sign up process to get started")
                            .padding(.leading, 10)
                            .padding(.top,1)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    HStack{
                        Text("Full name")
                            .padding(.leading,10)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    HStack{
                        TextField("Full name", text: $userViewModel.user.name)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                            .opacity(0.5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading,10)
                            .cornerRadius(10)
                        Spacer()
                        
                    }
                    HStack{
                        Text("Phone Number")
                            .padding(.leading,10)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    HStack{
                        TextField("Number", text: $userViewModel.user.phone_number)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                            .opacity(0.5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading,10)
                            .cornerRadius(10)
                        Spacer()
                        
                    }
                    HStack{
                        Text("Email Address")
                            .padding(.leading,10)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    HStack{
                        TextField("Email", text: $userViewModel.email)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                            .opacity(0.5)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading,10)
                            .cornerRadius(10)
                        Spacer()
                        
                    }
                    HStack{
                        Text("Password")
                            .padding(.leading,10)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    
                    HStack{
                        ZStack{
                            if bol {
                                SecureField("Password", text: $userViewModel.password)
                                    .foregroundColor(.gray)
                                    .font(.custom("Roboto-black",size:10))
                                    .opacity(0.5)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading,10)
                                    .cornerRadius(10)
                            }
                            else
                            {
                                TextField("Password", text: $userViewModel.password)
                                    .foregroundColor(.gray)
                                    .font(.custom("Roboto-black",size:10))
                                    .opacity(0.5)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading,10)
                                    .cornerRadius(10)
                                
                            }
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action:{if bol==false{
                                    img = "eye.slash"
                                    bol = true
                                }
                                    else{
                                        img = "eye"
                                        bol = false
                                    }})
                                {
                                    Image(systemName: img)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }.padding(.top, -10)
                    HStack{
                        Text("Confirm Password")
                            .padding(.leading,10)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                            .font(.custom("Roboto-black",size:10))
                        Spacer()
                    }
                    HStack{
                        ZStack{
                            if boll {
                                SecureField("Confirm Password", text: $userViewModel.confirmPassword)
                                    .foregroundColor(.gray)
                                    .font(.custom("Roboto-black",size:10))
                                    .opacity(0.5)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading,10)
                                    .cornerRadius(10)
                            }
                            else
                            {
                                TextField("Confirm Password", text: $userViewModel.confirmPassword)
                                    .foregroundColor(.gray)
                                    .font(.custom("Roboto-black",size:10))
                                    .opacity(0.5)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading,10)
                                    .cornerRadius(10)
                                
                            }
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action:{if boll==false{
                                    imgg = "eye.slash"
                                    boll = true
                                }
                                    else{
                                        imgg = "eye"
                                        boll = false
                                    }})
                                {
                                    Image(systemName: imgg)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                    }.padding(.top, -10)
                    HStack{
                        
                        Custom(value: $checkBox, valueColor: $col)
                            .padding()
                        ZStack{
                            Text("By ticking this box, you agree to our                                                                             ")
                            
                                .foregroundColor(.gray)
                                .font(.custom("Roboto-black",size:10))
                            Link("                                                    Terms and conditions and private policy", destination: URL(string: "https://google.com")!).padding(.leading,10)
                                .padding(.top,10)
                                .foregroundColor(.yellow)
                                .font(.custom("Roboto-black",size:10))
                        }
                    }
                    HStack{
                        //проверка состояния
                        if checkBox{
                            Button(action:{
                                if(userViewModel.password == userViewModel.confirmPassword)
                                    {
                                        Task{
                                            do{
                                                //выполнение сохранения
                                                userViewModel.signUp()
                                            }
                                        }
                                }
                                else{
                                    self.showingAlert = true
                                    
                                }
                                
                            }){
                                Text("Sing Up")
                                
                            }
                            .background(Color.blun)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Error"),
                                              message: Text("Password do not match"),
                                              dismissButton: .default(Text("OK")))
                                    }
                            .buttonStyle(MainButtonStyle(progress: userViewModel.isProgress))
                            


                            
                            
                        }
                            else{
                                Button(action:{}){
                                    Text("Sing Up")
                                    
                                }
                                .frame(width: 350, height: 30)
                                .font(.custom("Roboto-black",size:14))
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            }
                        }.padding(.top,40)
                        HStack{
                            ZStack{
                                
                                Text("Already have an account?                        ")
                                
                                    .foregroundColor(.gray)
                                    .font(.custom("Roboto-black",size:10))
                                
                                NavigationLink("                                       Sign in", destination: Login())
                                    .foregroundColor(.blun)
                                    .font(.custom("Roboto-black",size:10))
                                Spacer()
                            }
                        }.padding(10)
                        
                        
                        HStack{
                            Text("or sign in using")
                                .foregroundColor(.gray)
                                .font(.custom("Roboto-black",size:10))
                        }
                        Image(.gool)
                    }
                    .padding(10)
                }
            }.navigationBarBackButtonHidden()}
  
    }


#Preview {
    SignUp()
}
