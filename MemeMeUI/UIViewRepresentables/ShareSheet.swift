//
//  Share.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/11/23.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - UIActivityViewController for Sharing 

struct ShareViewController: UIViewControllerRepresentable {
    
    //the data you need to share....
    @Binding var topText: String
    @Binding var bottomText: String
    @Binding var imagePicked: UIImage?
    @Binding var memedImage: UIImage?
    //@State private var savedMeme: Meme?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        //define an instance of ActivityViewController
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        //completion handler
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            //create a meme if completed
            if completed {
                self.saveMeme(topText: self.topText, bottomText: self.bottomText, originalImage: self.imagePicked!, memedImage: self.memedImage!)
               
                
            }else{
                print("error")
            }
            
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    
    func saveMeme(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        
        let meme = Meme(topText: topText, bottomText: bottomText, original: originalImage, memed: memedImage)
        
    }
    
}

//class UIActivityVC: UIActivityViewController {
//        
//    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
//        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        guard let currentViewController = UIWindow().rootViewController else {
//            return
//        }
//        
//        currentViewController.present(self, animated: true)
//    }
//}
