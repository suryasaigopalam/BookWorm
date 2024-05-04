//
//  ContentView.swift
//  BookWorm
//
//  Created by surya sai on 01/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books:[Book]
    @State private var showingAddScreen = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading, content: {
                                Text(book.title)
                                    .font(.title)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            })
                        }
                    }
                   
                    
                }
                .onDelete(perform: { indexSet in
                   
                    deleteBooks(at: indexSet)
                    print(indexSet.count)                })
                
            }
            .navigationDestination(for: Book.self) {DetailView(book: $0)}
        
                .navigationTitle("BookWorm")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement:.topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingAddScreen = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .sheet(isPresented: $showingAddScreen, content: {
                    AddBookView()
                })
        }
    }
    func deleteBooks(at offSets:IndexSet) {
        print(offSets.hashValue)
        for offset in offSets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
    
}

#Preview {
    ContentView()
}
