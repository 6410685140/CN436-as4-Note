//
//  NotepadView.swift
//  Note
//
//  Created by นายธนภัทร สาระธรรม on 4/4/24.
//

import SwiftUI
import Firebase

struct NotepadView: View {
    @State private var message: String = ""
    @State private var savedMessages: [String] = []
    
    var body: some View {
        VStack {
            Text("Note Message")
                .font(.title)
                .padding()
            
            TextEditor(text: $message)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Button("Save", action: saveMessage)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(savedMessages.indices, id: \.self) { index in
                        HStack {
                            Text(savedMessages[index])
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Button(action: {
                                deleteMessage(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .foregroundColor(.black)
                
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .navigationBarTitle("Notepad")
        .onAppear {
            fetchMessages()
        }
    }
    
    func saveMessage() {
        savedMessages.append(message)
        saveMessageToFirebase(message)
        message = ""
    }
    
    func fetchMessages() {
        let db = Firestore.firestore()
        
        db.collection("messages").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                savedMessages.removeAll()
                for document in querySnapshot!.documents {
                    if let messageString = document.get("message") as? String {
                        savedMessages.append(messageString)
                    }
                }
            }
        }
    }
    
    func saveMessageToFirebase(_ message: String) {
        let db = Firestore.firestore()
        db.collection("messages").addDocument(data: ["message": message]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added")
            }
        }
    }
    
    func deleteMessage(at index: Int) {
        guard index < savedMessages.count else {
            print("Index out of range")
            return
        }

        let messageToDelete = savedMessages[index]
        savedMessages.remove(at: index)

        let db = Firestore.firestore()

        db.collection("messages").whereField("message", isEqualTo: messageToDelete).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            guard let document = querySnapshot?.documents.first else {
                print("Document not found")
                return
            }

            let documentID = document.documentID
            
            db.collection("messages").document(documentID).delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    print("Document successfully deleted")
                }
            }
        }
    }
    
}

struct NotepadView_Previews: PreviewProvider {
    static var previews: some View {
        NotepadView()
    }
}
