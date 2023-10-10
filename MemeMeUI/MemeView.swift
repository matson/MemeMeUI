//
//  ContentView.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/9/23.
//

import SwiftUI
import UIKit

struct MemeView: View {
    @State private var topText: String = ""
    @State private var bottomText: String = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                //Image("roses").resizable()
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
                    }){
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                
            }
            //bottom bar
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar){
                    HStack{
                        Button(action: {
                            save()
                        }) {
                            Image(systemName: "camera.fill")
                        }
                        Spacer()
                        Button("Album"){
                            print("going to Album")
                            
                        }
                    }
                }
            }
        }
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

