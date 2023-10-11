//
//  ImagePicker.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/10/23.
//

import Foundation
import UIKit
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    //Bound to var in MemeView
    @Binding var imagePicked : UIImage
    @Binding var sourceType: UIImagePickerController.SourceType
    //@Binding var shareButtonDisabled : Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        //set the delegate to coordinator
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = false
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker : PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                photoPicker.imagePicked = image
                //shareButtonDisabled = false
            }else{
                //return an error or show an alert
            }
            //need to dismiss controller
            picker.dismiss(animated: true)
        }
    }
    
    
    
}
