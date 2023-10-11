//
//  ContentView.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/9/23.
//
//for Image Picker,
//you need a coordinator to do all of this
//UIKit -> Coordinator -> SwiftUI

import SwiftUI
import UIKit

struct MemeView: View {
    @State private var topText: String = ""
    @State private var bottomText: String = ""
    @State private var imagePicked = UIImage()
    @State private var isShowingPicker = false
    @State private var isReadyToShare = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var shareButtonDisabled : Bool = true
    @State private var items: [Any] = []
    private var cameraButtonDisabled : Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }
    
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Image(uiImage: imagePicked)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack{
                    TextField("Top Text", text: $topText)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    TextField("Bottom Text", text: $bottomText)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                }
            }
            //top bar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isReadyToShare = true
                        items.removeAll()
                        items.append(generateMemedImage())
                        
                        isReadyToShare.toggle()
                    }){
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(shareButtonDisabled)
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
                        
                    }
                }
            }
        }.sheet(isPresented: $isShowingPicker, content: {
            PhotoPicker(imagePicked: $imagePicked, sourceType: $sourceType)
        }).sheet(isPresented: $isReadyToShare, content: {
            ShareSheet(items: items)
        })
        .onAppear(perform: {
            //stuff here
        })
    }
    
    //Generate a Meme
    func generateMemedImage() -> UIImage {
        
        //hide toolBar and NavBar
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show toolbar and navbar
        
        return memedImage
    }
    //Create a meme object
    func save(){
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: imagePicked, memeImage: generateMemedImage())
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemeView()
    }
    
}

//Left to Do:
//Share Button.
//Keyboard Stuff?
//TextField Font?

