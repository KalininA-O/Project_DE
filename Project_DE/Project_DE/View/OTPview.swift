//
//  OTPview.swift
//  Project_DE
//
//  Создал Калинин Арсений Олегович 12.10.2024.
//  Структура для реализации отправки токена

import SwiftUI

struct OTPview: View {
    @State private var NavigationNewPass: Bool = false
    @ObservedObject var forgetViewModel : ForgetViewModel
    @StateObject var otpViewModel = OTPViewModel()
    @State private var showingAlert = false
    @State private var code: [String] = Array(repeating: "", count: 6)
    @State private var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()//таймер
    @State var count: Int = 60
    @State private var buttonDisabled: Bool = true
    @State private var anotherError: Bool = false
    var body: some View {
        NavigationView{
            
            VStack{
                //навигация
                NavigationLink(destination: NewPassword(), isActive: $otpViewModel.isNavigate)
                {EmptyView()}
                HStack{
                    Text("OTP Verification")
                        .padding(.leading, 10)
                    
                        .font(.custom("Roboto-black",size:20))
                    
                    
                    Spacer()
                }
                HStack{
                    Text("Enter the 6 digit numbers sent to your email")
                        .padding(.leading, 10)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                        .font(.custom("Roboto-black",size:10))
                    Spacer()
                }
                VStack {
                    HStack {
                        ForEach(code.indices, id: \.self) { index in
                            rectangleCode(value: $code[index])
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    HStack {
                        Text("If you didn’t receive code,")
                            .font(.custom("Roboto-black",size:14))
                            .foregroundStyle(Color.gray)
                        
                        if count > 0 {
                            Text("resend after \(count == 60 ? "1:00" : count > 9 ? "0:\(count)" : "0:0\(count)")")
                                .font(.custom("Roboto-black",size:14))
                                .foregroundStyle(Color.gray)
                        } else {
                            Button("resend") {
                                forgetViewModel.send()
                            }
                            .font(.custom("Roboto-black",size:14))
                            .foregroundStyle(Color.accentColor)
                        }
                    }.padding(.top, 20)
                }.padding(.top, 30)
                HStack{//проверка состояния
                    if(!buttonDisabled)
                    {
                        Button(action:{
                            //отправка токена для проверки
                            otpViewModel.email = forgetViewModel.email
                            otpViewModel.code = code
                            if(code.joined() != "")//проверка состояния
                            {
                                otpViewModel.send()
                            }
                            else{
                                self.showingAlert = true
                            }
                            
                        }){
                            Text("Set New Password")
                            
                        }
                        .background(Color.blun)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .alert(isPresented: $otpViewModel.error) {
                            Alert(title: Text("Error"),
                                  message: Text("Error supabase"),
                                  dismissButton: .default(Text("OK")))
                        }
                        .buttonStyle(MainButtonStyle(progress: otpViewModel.isProgress))
                        .disabled(buttonDisabled)
                        
                    }
                    else{
                        Button(action:{}){
                            Text("Set New Password")
                            
                        }
                        .font(.custom("Roboto-black",size:14))
                        .frame(width: 350, height: 30)
                        .padding(10)
                        .background(Color.gr)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                }.padding(.top,30)
                    .padding(10)
            }
            }.navigationBarHidden(true)//событие начала таймера
                .onReceive(timer, perform: { _ in
                    count -= 1
                    
                    if count < 0 {
                        stopTimer()
                    }
                })//событие изменения
                .onChange(of: code) { value in
                    let disabled = value.reduce(false) { partialResult, item in
                        return partialResult ? true : item.isEmpty
                    }
                    
                    self.buttonDisabled = disabled
                }
                .navigationBarBackButtonHidden()
        
        
    }
    //остановка таймера
    func stopTimer () {
        timer.upstream.connect().cancel()
    }
    //оформление токена
    @ViewBuilder func rectangleCode(value: Binding<String>) -> some View {
        TextField("", text: value)
            .font(.custom("Roboto-black",size:15))
            .keyboardType(.numberPad)
            .frame(width: 32, height: 32)
            .multilineTextAlignment(.center)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(anotherError ? Color.red : value.wrappedValue.isEmpty ? Color.gray : Color.accentColor, lineWidth: 1)
            )
            
    }
    
    
}

#Preview {
    OTPview(forgetViewModel: ForgetViewModel())
}
