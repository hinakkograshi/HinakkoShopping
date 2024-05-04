//
//  ImagePicker.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/09.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    func makeUIViewController(context: Context) -> some PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self,
                                              completionHandler: { (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self.parent.image = image
                        }
                    }
                }
                )
            }
        }
    }
}
