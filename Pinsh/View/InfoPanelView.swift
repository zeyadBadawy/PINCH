//
//  InfoPanelView.swift
//  Pinsh
//
//  Created by Zeyad Badawy on 16/04/2022.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale:CGFloat
    var offset:CGSize
    
    @State private var isShown:Bool = false
    
    
    var body: some View {
        HStack {
            //MARK: CIRCLE BUTTON
            
            Image(systemName: "circle.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1 ) {
                    withAnimation {
                        isShown.toggle()
                    }
                }

            Spacer()
            
            //MARK: READINGS ICONS
            
            HStack(spacing:2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth:420)
            .opacity(isShown ? 1 : 0)
            
            Spacer()
            
        }//: Hstack
        
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
