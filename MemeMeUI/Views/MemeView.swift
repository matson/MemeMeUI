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
    @State private var cameraButtonDisabled: Bool = false
    @State private var shareButtonDisabled: Bool = true
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
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
                        share()
                        canShare()
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
                            fixCamera()
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
        })
    }
    
    //Helper functions
    
    func fixCamera(){
        #if targetEnvironment(simulator)
            cameraButtonDisabled = true
        #else
            cameraButtonDisabled = false
        #endif
    }
    
    func canShare(){
        
    }
    
}

func save() {
    print("saved")
}

func share() {
    print("share")
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemeView()
    }
    
}

