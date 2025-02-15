//
//  ContentView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    var coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            VStack {
                List( viewModel.filteredResponse, id: \.word) { word in
                    Button(action: {
                        coordinator.showWordDetails(for: word)
                    }) {
                        HStack {
                            Text(word.word.capitalized)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Dictionary")
//            .overlay(
//                ToastView(message: viewModel.errorMessage ?? "")
//                    .opacity(viewModel.errorMessage == nil ? 0 : 1)
//            )
        }
        .searchable(text: $viewModel.searchText, prompt: "Search for a word")
        .onSubmit(of: .search) {
            viewModel.searchWord(viewModel.searchText) 
        }
      

    }

  
}
