//
//  Share.swift
//  MemeMeUI
//
//  Created by Tracy Adams on 10/11/23.
//

import Foundation
import UIKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    //the data you need to share....
    var items: [Any]
//    @Binding  var topText: String
//    @Binding  var bottomText: String
//    @Binding  var imagePicked : UIImage
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        //define an instance of ActivityViewController
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //completion handler
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            //create a meme if completed
            if completed {
                self.save()
            }
            //self.dismiss(animated: true, completion: nil)
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
  
}
