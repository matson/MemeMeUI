//
//  ContentView.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/9/23.

import SwiftUI
import UIKit

struct MemeSwiftUIView: View {
    
    @State private var topText: String = ""
    @State private var bottomText: String = ""
    @State private var imagePicked: UIImage?
    @State private var memedImage: UIImage?
    @State private var isShowingPicker = false
    @State private var isReadyToShare = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var shareButtonEnabled = false
    
    //MARK: - The View and Attributes
    
    var body: some View {
        
        NavigationStack {
            features
            //top bar
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            generateMemedImage()
                            isReadyToShare = true
                            //activityController(isPresented: $isReadyToShare)
                            
                        }){
                            Image(systemName: "square.and.arrow.up")
                        }
                        .disabled(!shareButtonEnabled)
                        .sheet(isPresented: $isReadyToShare, content: {
                            ShareViewController(topText: $topText, bottomText: $bottomText, imagePicked: $imagePicked, memedImage: $memedImage)
                        })
                    }
                    
                }
            //bottom bar
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar){
                        HStack{
                            //Camera
                            Button(action: {
                                isShowingPicker = true
                            }) {
                                Image(systemName: "camera.fill")
                            }
                            .disabled(cameraButtonDisabled)
                            Spacer()
                            //Album
                            Button(action : {
                                isShowingPicker = true
                                sourceType = .photoLibrary
                            }){
                                Text("Album")
                            }
                            .sheet(isPresented: $isShowingPicker, content: {
                                PhotoPicker(imagePicked: $imagePicked, sourceType: $sourceType, shareButtonEnabled: $shareButtonEnabled)
                            })
                            
                        }
                    }
                }
        }
        
        
    }
    //original ImageView and two Textfields:
    var features: some View {
        ZStack{
            Image(uiImage: imagePicked ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                TextField("Top Text", text: $topText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .shadow(color: .black, radius: 9)
                
                
                Spacer()
                
                TextField("Bottom Text", text: $bottomText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .shadow(color: .black, radius: 9)
                    
            }
        }
    }
    
    //Only disable the camera button if we are using a simulator
    private var cameraButtonDisabled : Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    

    //MARK: -  Helper Functions
    
    
    //Instead of using UIGraphicsBeginImageContext in Storyboard, we use UIGraphicsImageRenderer
    func generateMemedImage() {
        guard let image = imagePicked else { return }
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let memedImage = renderer.image { _ in
            image.draw(at: CGPoint.zero)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let memeAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 50),
                .foregroundColor: UIColor.white,
                .strokeColor: UIColor.black,
                .strokeWidth: -5,
                .paragraphStyle: paragraphStyle
            ]
            
            let topTextRect = CGRect(x: 0, y: 20, width: image.size.width, height: 100)
            topText.draw(in: topTextRect, withAttributes: memeAttributes)
            
            let bottomTextRect = CGRect(x: 0, y: image.size.height - 100, width: image.size.width, height: 100)
            bottomText.draw(in: bottomTextRect, withAttributes: memeAttributes)
        }
        
        self.memedImage = memedImage
    }

}

//extension MemeSwiftUIView {
//    func activityController(isPresented: Binding<Bool>) -> some View {
//        return self
//            .background {
//              if isPresented.wrappedValue {
//                  ShareViewController(topText: $topText, bottomText: $bottomText, imagePicked: $imagePicked, memedImage: $memedImage)
//              }
//            }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemeSwiftUIView()
    }
    
}

