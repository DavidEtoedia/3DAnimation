//
//  HeadsetsView.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 27/10/2023.
//

import SwiftUI
import SceneKit
import SpriteKit

struct HeadsetsView: View {
    
    var headsets: HeadsetModel
     var scene: SCNScene? = nil
    
//    init(headsets: HeadsetModel) {
//        self.headsets = headsets
//        self._scene = State(initialValue: SCNScene(named: headsets.name))
//    }
    
    var body: some View {
        CustomSceneView(scene: scene)
            .frame(height: 300)
        
    }
}

struct HeadsetsView_Previews: PreviewProvider {
    static var previews: some View {
        HeadsetsView(headsets: .model())
    }
}
