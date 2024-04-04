//
//  LoginView.swift
//  NoteApp
//
//  Created by นายธนภัทร สาระธรรม on 3/4/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var navigateToNotepad = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Note", subtitle: "Get things done", angle: 15, background: .pink)
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    TLButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                }
                VStack {
                    Text("New Around Here")
                    NavigationLink("Create an Account", destination: RegisterView())
                }
                
                Button(action: {
                    navigateToNotepad = true
                }) {
                    Text("Notepad")
                }
                NavigationLink(destination: NotepadView(), isActive: $navigateToNotepad) {
                    EmptyView()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
