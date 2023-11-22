//
//  Sample.swift
//  HeadPhones
//
//  Created by Inyene Etoedia on 14/11/2023.
//

import SwiftUI

struct Sample: View {
    @State var details = false
    
    @Namespace var animation
    @State var selected = 0
    
    @State var selectedId = ""
    
    var body: some View {
      
            VStack {
                ForEach(headset.indices, id: \.self) { val in
                    Rectangle()
                        .matchedGeometryEffect(id: val.description, in: animation)
                        .frame(width: 100, height: 100)
                        .background{
                            Rectangle()
                                .matchedGeometryEffect(id: headset[val].id, in: animation)
                                .foregroundColor(.red)
                                .frame(width: 200, height: 200)
                        }
                        .onTapGesture {
                            withAnimation {
                                details.toggle()
                                selected = val
                                selectedId = headset[val].id
                            }
                        }
                }
            }
            //.zIndex(1)
            .overlay{
                if details {
                    AnotherView(details: $details, id: selected, selectedid: selectedId, animation: animation)
                 
                        .zIndex(2)
                }
            }
            
          
        
//        ZStack {
//            
//            HStack {
//                Rectangle()
//                    .frame(width: 100, height: 100)
//                    .matchedGeometryEffect(id: "id1", in: animation)
//                    .onTapGesture {
//                        withAnimation {
//                            details.toggle()
//                        }
//                    }
//                
//                
//                Spacer()
//            }
//            .zIndex(1)
//            
//            if details == true {
//                AnotherView(details: $details, id: selected , animation: animation)
//                    .zIndex(2)
//            }
//        }
    }
}


struct AnotherView: View {
    @Binding var details: Bool
   var id: Int
    var selectedid: String
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
         
            
            Rectangle()
                .matchedGeometryEffect(id: id.description, in: animation)
                .frame(width: 100, height: 100)
                .background{
                    Rectangle()
                        .matchedGeometryEffect(id: selectedid, in: animation)
                        .foregroundColor(.red)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                }
                .onTapGesture {
                    withAnimation {
                        details.toggle()
                    }
                }
        }
    }
}

#Preview {
    Sample()
}
