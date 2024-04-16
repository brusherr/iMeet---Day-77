//
//  AddView-ViewModel.swift
//  MeetUpChallenge
//
//  Created by Yordan Dimitrov on 16.04.24.
//

import Foundation
import SwiftUI
import PhotosUI

extension AddView {
    @Observable
    class ViewModel {
        var name: String = ""
        var selectedPhoto: PhotosPickerItem?
        var dataImage: Data?
        var personPhoto: Image?
        
        
        
        func loadImage() async throws {
            guard let dataImage = try await selectedPhoto?.loadTransferable(type: Data.self) else { return }
            self.dataImage = dataImage
            convertToImage()
        }
        
        private func convertToImage() {
            guard let dataImage = self.dataImage else { return }
            guard let uiImage = UIImage(data: dataImage) else { return }
            personPhoto = Image(uiImage: uiImage)
        }
        
        func addNewPerson() -> Person {
            let newPerson = Person(id: UUID(), dataImage: dataImage ?? Data(), name: name)
            
            return newPerson
        }
    }
}

