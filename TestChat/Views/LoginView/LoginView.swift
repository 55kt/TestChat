import SwiftUI

struct LoginView: View {
    
    //MARK: - Properties
    @StateObject private var fbm = FirebaseManager.shared
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    // Nav Bar Picker Buttons
                    Picker(selection: $fbm.isLoginMode, label: Text("Picker here")) {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // Icon Add Button Area
                    if !fbm.isLoginMode {
                        Button {
                            fbm.shouldShowImagePicker.toggle()
                        } label: {
                            VStack {
                                if let image = fbm.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .scaledToFill()
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 64))
                                        .padding()
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(.gray, lineWidth: 1)
                                .opacity(0.5)
                            )
                        }
                    }
                    
                    // Fields Area
                    Group {
                        TextField("Email", text: $fbm.user.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        PasswordField(password: $fbm.user.password)
                        if !fbm.isLoginMode {
                            TextField("Nickname", text: $fbm.user.nickname)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // Auth Button
                    CustomButton(buttonTitle: fbm.isLoginMode ? "Log In" : "Create Account") {
                        handleAction()
                    }
                    Text(fbm.loginStatusMessage) /// Action Text invisible
                        .foregroundColor(.red)   ///
                }
                .padding()
            }
            
            // Nav Bar Text
            .navigationTitle(fbm.isLoginMode ? "Log In" : "Create Account")
            .background(Image("sky_background_blur")
                .blur(radius: 3)
                .ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $fbm.shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $fbm.image)
        }
    }
    
    // Auth Function
    func handleAction() {
        if fbm.isLoginMode {
            fbm.loginUser()
        } else {
            fbm.createNewAccount()
        }
    }
}

//MARK: - Preview
#Preview {
    LoginView()
}

