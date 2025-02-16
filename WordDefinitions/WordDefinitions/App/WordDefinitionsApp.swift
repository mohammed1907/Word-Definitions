//
//  WordDefinitionsApp.swift
//  WordDefinitions
//
//  Created by mohamed hassan on 14/02/2025.
//

import SwiftUI

@main
struct WordDefinitionsApp: App {
    init() {
          ArrayTransformer.register() 
      }
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
