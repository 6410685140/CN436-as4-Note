//
//  NoteAppItemView.swift
//  NoteApp
//
//  Created by นายธนภัทร สาระธรรม on 3/4/2567 BE.
//

import SwiftUI

struct NoteAppItemView: View {
    @StateObject var viewModel = NoteAppItemViewModel()
    let item: NoteAppItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
            
        }
    }
}

struct NoteAppItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoteAppItemView(item: NoteAppItem(id: "123", title: "Get Milk", dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: true))
    }
}
