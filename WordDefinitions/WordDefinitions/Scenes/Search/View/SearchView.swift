//
//  ContentView.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: DictionaryViewModel
    var coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            VStack {
                SearchTextField(text: $viewModel.searchText, onSearch: {
                    viewModel.searchWord(viewModel.searchText)
                })
                
                List(viewModel.wordList, id: \.word) { word in
                    Button(action: {
                        coordinator.showWordDetails(for: word) 
                    }) {
                        HStack {
                            Text(word.word.capitalized)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Spacer()

                            if viewModel.cacheManager.isWordCached(word) {
                                Image(systemName: "clock.arrow.circlepath") // ✅ Cached icon
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Dictionary")
            .overlay(
                ToastView(message: viewModel.errorMessage ?? "")
                    .opacity(viewModel.errorMessage == nil ? 0 : 1)
            )
        }
    }
}
