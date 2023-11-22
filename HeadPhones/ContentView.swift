//
//  ContentView.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 25/10/2023.
//

import SwiftUI
import SceneKit

struct MainView: View {
    @State private var vm = ObjectViewModel()
    @Namespace private var phoneNS
    @State var rotate: CGFloat = 0.0
    @State var scale: CGFloat = 2.0
    @State var currentItem : HeadsetModel?
    @State var width: CGFloat = 100
    @State var selected: Int?
    @State var previous: Int?
    @State var details = false
    @State var selecteds: Int?
    var bg = #colorLiteral(red: 0.1139839962, green: 0.1167554036, blue: 0.1132470444, alpha: 1)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.93))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView {
                ForEach(vm.headset.indices, id: \.self) { index in
                     
                    HStack{
                        VStack(spacing: 0){
                            
                            Text(vm.headset[index].title)
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                                .opacity(currentItem?.title == vm.headset[index].id ? 0 : 1)
                                .frame(maxWidth: .infinity, maxHeight: 10, alignment: .leading)
                            
                            Text(vm.headset[index].subtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: vm.headset[index].subtitle, in: phoneNS, isSource: true)
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
       
                        CustomSceneView(scene: vm.headset[index].scene)
                            .matchedGeometryEffect(id: vm.headset[index].id, in: phoneNS, isSource: true)
                            .frame(height: 150)
                        
                    }
                    .zIndex(selecteds == index  ? 1 : 0)
                    .padding()
                    .background{
                        
                        Rectangle()
                            .matchedGeometryEffect(id: vm.headset[index].name, in: phoneNS)
                            .foregroundColor(Color(bg))
                    }
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.7)) {
                            
                            withAnimation(.easeInOut(duration: 0.7)){
                                selecteds = index
                                currentItem = vm.headset[index]
                                details.toggle()
                                
                            }
                            
                            withAnimation(.easeInOut(duration: 0.6)) {
                                SCNTransaction.animationDuration = 0.9
                                
                                vm.headset[index].scene?.rootNode.childNode(withName:  vm.headset[index].node, recursively: true)?.eulerAngles.y = Float(-185.5 / 27 )
                                
                            
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ){
                                withAnimation(.easeInOut(duration: 2.6)) {
                                    
                                    SCNTransaction.animationDuration = 2.6
                                    vm.headset[index].scene?.rootNode.childNode(withName:  vm.headset[index].node, recursively: true)?.eulerAngles.y = Float(-188.5 / 27)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
            if  details{
                DetailsView(
                    details: $details,
                    item: currentItem, id: currentItem!.id.description, phoneNS: phoneNS)
                
            }
            
        }
    }

}

#Preview {
    MainView()
}


struct DetailsView: View {
    @Binding var details: Bool
    let item: HeadsetModel?
    let id: String
    let phoneNS: Namespace.ID
    @State var offset : CGFloat = 0.0
    @State var offsetButtn : CGFloat = 600
    @State var offsetText : CGFloat = 200
    @State var offsetPhone : CGFloat = 150
    @State var showPhone: Bool = false
    @State var showDevice: Bool = false
    @State var showHeader: Bool = false
    @State var showTitle: Bool = false
    @State var moveUp: Bool = false
   @State var scenes = SCNScene(named: "")
    var bg = #colorLiteral(red: 0.1139839962, green: 0.1167554036, blue: 0.1132470444, alpha: 1)
    
    init(details: Binding<Bool>, item: HeadsetModel?, id: String, phoneNS: Namespace.ID) {
        self._details = details
        self.item = item
        self.id = id
        self.phoneNS = phoneNS
        self.offset = offset
        self.offsetButtn = offsetButtn
        self.offsetText = offsetText
        self.showHeader = showHeader
        self.showTitle = showTitle
        self.offsetPhone = offsetPhone
        self._scenes = State(initialValue: SCNScene(named: item!.subName))
    }
    
    var body: some View {

        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.leading, 30)
                    .opacity(showDevice ? 0 : 1)
                    .padding(10)
                    .background{
                        Circle()
                            .fill(.gray.opacity(0.3))
                            .opacity(showDevice ? 0 : 1)
                            .padding(.leading, 30)
                    }
                    .onTapGesture {
                    
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showHeader.toggle()
                            showTitle.toggle()
                            offset = 600
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ){
                            withAnimation(.easeInOut(duration: 0.8)) {
                                
                                SCNTransaction.animationDuration = 1
                                details = false
                                if let scale =
                                    item!.scene?.rootNode.childNode(withName: item!.node, recursively: true){
                                    scale.scale.x = 1.0
                                    scale.scale.y = 1.0
                                    scale.scale.z = 1.0
                                    scale.position.y = 0.0
                                    scale.eulerAngles.y = 0
                                }
                            }
                        }
                }
                
                Spacer()
                
                 Text("Close")
                     .font(.system(size: 15, weight: .light))
                     .foregroundColor(.white)
                     .opacity(showDevice ? 1 : 0)
                     .padding(10)
                     .background{
                         Rectangle().fill(.gray.opacity(0.4))
                             .opacity(showDevice ? 1 : 0)
                             .cornerRadius(30)
                     }
                     .padding(.trailing, 30)
                     .onTapGesture {
                         
                         withAnimation(.easeInOut(duration: 0.5)) {
                            showDevice = false
                             SCNTransaction.animationDuration = 1.5
                             scenes?.rootNode.eulerAngles.y = -0.0
                         }
                         
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                             
                             withAnimation(.easeInOut(duration: 1.2)) {
                                 offsetButtn = 0
                                
                                
                             }
                             
                         }
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                             withAnimation(.easeInOut(duration: 1)) {
                                 showHeader = true
                                 showTitle = true
                                 showPhone = false
                                 offsetText = -200
                                 moveUp.toggle()
                             }
                             
                         }
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                             withAnimation(.easeInOut(duration: 1.9)) {
                                 SCNTransaction.animationDuration = 1.5
                                 if let scale =
                                     item!.scene?.rootNode.childNode(withName: item!.node, recursively: true){
                                     scale.position.y = 0
                                     scale.scale.x = 0.5
                                     scale.scale.y = 0.5
                                     scale.scale.z = 0.5
                                     scale.eulerAngles.y = Float(-188.5 / 27)
                                  
                                 }
                             }
                         }
                     
                         
                     }
            }
            .zIndex(1)
                
    
            
            ZStack(alignment: .leading) {
                VStack( alignment:.leading, spacing: 0){
                    Text(item!.title)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(showHeader ? 1 : 0)
                        .offset(y: showHeader ? 10 : 0)
                    
                    Text(item!.subtitle)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.white)
                        .offset(y: showTitle ? 13 : -10)
                        .opacity(showTitle ? 1 : 0)
                        
                }
                .padding(.horizontal, 30)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
          
 
            CustomSceneView(scene: item!.scene)
                .matchedGeometryEffect(id: id.description, in: phoneNS, isSource: false)

            
            ZStack {
             
                    CustomSceneView(scene: scenes)
                    .offset(y: showDevice ? 10 : 200)
                        .opacity(showDevice ? 1 : 0)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).animation(.easeInOut(duration: 1.3).delay(showDevice ? 1.0 : 0)),
                            removal: .move(edge: .top).animation(.easeInOut(duration: 1.0))
                        ))
                       .animation(.easeInOut(duration: 1.0), value: showDevice)
                VStack {
                    Spacer()
                    HStack{
                            VStack(alignment: .leading) {
                                HStack{
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    Image(systemName: "star")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    Image(systemName: "star")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                }
                                
                                Spacer()
                                    .frame(height: 10)
                                Text("item!.subtitle")
                                    .font(.system(size: 13, weight: .light))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        
                            Image(systemName: "arrow.up")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .opacity(offsetButtn < 0.0 ? 0 : 1)
                                .offset( y: moveUp ? -8 : 5)
                                .animation(.easeInOut(duration: 0.2).delay(0.1).repeatForever(autoreverses: true), value: moveUp)
                                .onAppear{
                
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                        moveUp.toggle()
                                    }
                                }
                           
                              
                            Spacer()

                            Text("Buy Now")
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .background{
                                    Rectangle().fill(.red)
                                        .frame(width: 100, height: 40)
                                        .cornerRadius(30)
                                }
                        }
                       
                }
                .opacity(offsetButtn == -450 ? 0 : 1)
                .padding(.horizontal, 20)
                .offset(y: offsetButtn)

                    VStack{
                        Text(item!.title)
                            .font(.system(size: 45, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 50)
                            
                            Text(dummytext)
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(.white)
                                .padding(.horizontal, 50)
                    }
                    .opacity(showPhone ? 1 : 0)
                    .offset(y: offsetText)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                   .animation(.easeInOut(duration: 0.8), value: showPhone)
          
               
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .leading)
        .background{
            
            Rectangle()
                .fill(Color(bg))
                .matchedGeometryEffect(id: item!.name, in: phoneNS)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Rectangle()
                .fill(Color(bg))
                .matchedGeometryEffect(id: id.description, in: phoneNS)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .onAppear{
 
            withAnimation (.linear(duration: 1.2))  {
                offsetButtn = 0
            }

            
            withAnimation(.linear(duration: 0.6).delay(0.3)) {
                showHeader = true
                showTitle = true
            }
            
            if let scale =
                item!.scene?.rootNode.childNode(withName: item!.node, recursively: true){
                scale.scale.x = 0.5
                scale.scale.y = 0.5
                scale.scale.z = 0.5

            }
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    offset = value.location.y
                    
                    withAnimation(.easeInOut(duration: 0.6)) {
                        offsetButtn = -650
                      
                    }
                    withAnimation(.easeInOut(duration: 0.5).delay(0.15)) {
                        offsetText = -300
                    }
                    withAnimation(.easeInOut(duration: 0.1).delay(0.1)) {
                        showPhone = true
                    }
                    
                    withAnimation(.easeInOut(duration: 0.1).delay(0.15)) {
                        showDevice = true
                    }
                 
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12){
                        
                        
                        if (item?.subName == "airpod2.scn"){
                            
                            withAnimation(.easeInOut(duration: 0.7)) {
                                
                                SCNTransaction.animationDuration = 1
                                scenes?.rootNode.scale.x = 1.0
                                scenes?.rootNode.scale.y = 1.0
                                scenes?.rootNode.scale.z = 1.0
                                scenes?.rootNode.eulerAngles.y = Float(-135 / 50)
                                
                                
                            }
                        }else{
                               withAnimation(.easeInOut(duration: 0.7)) {
                                   SCNTransaction.animationDuration = 1
                                   scenes?.rootNode.scale.x = 1.3
                                   scenes?.rootNode.scale.y = 1.3
                                   scenes?.rootNode.scale.z = 1.3
                                   scenes?.rootNode.eulerAngles.y = Float(-135 / 50)
                                   
                                   
                               }
                        }

                    }
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ){
                        withAnimation(.easeInOut(duration: 1)) {
                            
                            SCNTransaction.animationDuration = 1.1
                            scenes?.rootNode.eulerAngles.y = Float(158.5 / 20)
                        
                        }
                    }

                    
                    withAnimation(.easeIn) {
                        if offset != 0.0 {
                            SCNTransaction.animationDuration = 1
                            showHeader = false
                            showTitle = false
                            
                            if let scale =
                                item!.scene?.rootNode.childNode(withName: item!.node, recursively: true){
                                scale.position.y = 0.05
                                
                                scale.scale.x = 0.1
                                scale.scale.y = 0.1
                                scale.scale.z = 0.1
                                scale.eulerAngles.y = 0
                                
                            }
                        }
                        
                        
                    }
                  
                })
        
        )
      
    }
}





