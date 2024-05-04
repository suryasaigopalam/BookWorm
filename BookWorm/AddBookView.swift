//
//  AddBookView.swift
//  BookWorm
//
//  Created by surya sai on 02/05/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dissmiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let generes = ["Fantasy","Horror","Kids","Mystery","Poetry","Romance","Thriller"]
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Name of the Book",text: $title)
                        TextField("Author's name",text: $author)
                        Picker("Genre",selection: $genre) {
                            ForEach(generes,id: \.self) {Text($0)}
                        }
                    }
                    Section("Write Review"){
                        TextEditor(text: $review)
                       RatingView(rating: $rating)
                        }
                    }
                 
                }
                Button("Save") {
                    let book = Book(title: title, author: author, genre: genre, reveiw: review, rating: rating)
                    modelContext.insert(book)
                   dissmiss()
                }
                .padding(.all,12)
                .background(.green)
                .clipShape(.rect(cornerRadius: 10))
                .foregroundColor(.white)
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
            
    }


#Preview {
    AddBookView()
}
