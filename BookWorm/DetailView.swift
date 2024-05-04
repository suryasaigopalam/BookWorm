//
//  DetailView.swift
//  BookWorm
//
//  Created by surya sai on 03/05/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State var showAlert = false
    let book:Book
    var body: some View {
        ScrollView {
            ZStack(alignment:.bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5,y: -5 )
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.reveiw)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("DeleteBook",isPresented: $showAlert) {
            Button("Delete",role: .destructive,action: deleteBook)
            Button("Calcel",role:.cancel,action: {})
            
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("trash",systemImage: "trash"){showAlert = true}
        }
    }
        
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Sample", author: "Sample", genre: "Fantasy", reveiw: "Sample", rating: 5)
       return DetailView(book: example)
        .modelContainer(container)
    }catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
