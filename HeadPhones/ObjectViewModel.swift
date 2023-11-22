//
//  ObjectViewModel.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 18/11/2023.
//

import Foundation
import SceneKit

class ObjectViewModel: ObservableObject {
    
    @Published var headset : [HeadsetModel] = HeadsetModel.headsets
    @Published var selectedIndex = 0
    @Published var selectedImage: HeadsetModel? = nil
      
      func selectPhone(_ image: HeadsetModel) {
          if let index = headset.firstIndex(where: {$0 == image}) {
              selectedIndex = index
              headset.remove(at: index)
              selectedImage = image
              
          }
      }
    
    func unselectPhone() {
          if let selectedImage {
              self.selectedImage = nil
              headset.insert(selectedImage, at: selectedIndex)
          }
      }
    
}
