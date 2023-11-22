//
//  SceneView.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 25/10/2023.
//

import SwiftUI
import SceneKit


struct CustomSceneView: UIViewRepresentable {
     var scene: SCNScene?

    
    func makeUIView(context: Context) ->  SCNView {
        
        //var scenes = SCNScene(named: "fiat.usdz")
        
        let view = SCNView()
        let ambientLight = SCNLight()
        let camera = SCNNode()
        view.allowsCameraControl = false
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
       // scene?.rootNode.scale = SCNVector3(0.6, 0.6, 0.6)
       // scenes?.rootNode.rotation = SCNVector4(1.5, 1.5, 2.3, 1.5)
        ambientLight.color = UIColor.darkGray
        ambientLight.type = SCNLight.LightType.ambient
        camera.light = ambientLight
        scene?.rootNode.addChildNode(camera)
    
     
        
        view.scene = scene
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
      //  scene?.rootNode.eulerAngles.y = Float((rotate * .pi) / 180)
        
//        scene?.rootNode.childNode(withName: "mainNode", recursively: true)?.eulerAngles.x = Float((rotate * .pi) / 180)
        
        
    }
    

    
  
}

struct CustomSceneView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSceneView()
    }
}
