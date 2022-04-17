//
//  ContentView.swift
//  Pinsh
//
//  Created by Zeyad Badawy on 16/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: PROPERTIES
    
    @State private var isAnimation:Bool = false
    @State private var scaleImage:CGFloat = 1
    @State private var imageOffset:CGSize = .zero
    @State private var isDrawerOpen:Bool = false
    @State private var imageIndex:Int = 1
    
    //MARK: FUNCTIONS
    
    private func resetImageState() {
        scaleImage = 1
        imageOffset = .zero
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.clear
                
                //MARK: MAIN IMAGE
                Image(pages[imageIndex - 1 ].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimation)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .animation(.spring(), value: scaleImage)
                    .scaleEffect(scaleImage)
                    .animation(.spring(), value: imageOffset)
                    .onTapGesture(count: 2) {
                        if scaleImage == 1 {
                            scaleImage = 5
                        }else {
                            resetImageState()
                        }
                    } // ADD DRAG GESTURE
                    .gesture (
                        DragGesture()
                            .onChanged({ value in
                                imageOffset = value.translation
                            })
                            .onEnded({ _ in
                                if scaleImage <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                // ADD MAGNIFIER GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration:1)) {
                                    if scaleImage <= 5 && scaleImage >= 1 {
                                        scaleImage = value
                                    }else if scaleImage > 5 {
                                        scaleImage = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                withAnimation(.linear(duration:1)) {
                                    if scaleImage > 5 {
                                        scaleImage = 5
                                    }else if scaleImage <= 1 {
                                        resetImageState()
                                    }
                                }
                            })
                        
                    )
                
            } //: ZSTSCK
            //MARK: INFO PANEL
            .overlay(alignment: .top, content: {
                InfoPanelView(scale: scaleImage, offset: imageOffset)
                    .padding(.horizontal)
                
            })
            //MARK: CONTROLS
            .overlay(alignment: .bottom, content: {
                Group {
                    HStack {
                        // Zoom in
                        Button {
                            if scaleImage <= 1 {
                                resetImageState()
                            }
                            
                            if scaleImage > 1 {
                                scaleImage -= 1
                            }
                            
                        } label: {
                            Image(systemName: "minus.magnifyingglass")
                                .font(.system(size: 33))
                        }
                        // Reset
                        Button {
                            resetImageState()
                        } label: {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                .font(.system(size: 33))
                        }
                        // Zoom out
                        Button {
                            if scaleImage < 5 {
                                scaleImage += 1
                            }
                            
                            if scaleImage == 5 {
                                resetImageState()
                            }
                            
                        } label: {
                            Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 33))
                        }
                    }
                    
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimation ? 1 : 0 )
                
            })
            .animation(.spring(), value: scaleImage)
            .padding(.bottom , 30)
            .onAppear(perform: {
                isAnimation = true
            })
            .navigationTitle("Pinsh & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            
            //MARK: DRAWER
            .overlay(alignment: .topTrailing, content: {
                HStack (spacing: 12){
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height:40)
                        .foregroundStyle(.secondary)
                        .padding(8)
                        .onTapGesture(count: 1) {
                            withAnimation(isDrawerOpen ? .easeOut(duration:0.25) : .easeIn(duration:0.25)) {
                                isDrawerOpen.toggle()
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onEnded({ _ in
                                    withAnimation {
                                        isDrawerOpen.toggle()
                                    }
                                })
                        )
                    
                    ForEach(pages) { item in
                        Image(item.thumpnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width:80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1:0)
                            .animation( isDrawerOpen ? .easeIn(duration:0.5) : .easeOut(duration:0.25), value: isDrawerOpen)
                            .onTapGesture {
                                withAnimation(.easeIn(duration:0.25)) {
                                    imageIndex = item.id
                                    isAnimation = true
                                    resetImageState()
                                }
                                
                                
                            }
                    }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .opacity(isAnimation ? 1 : 0)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .frame(width: 260)
                .offset(x: isDrawerOpen ? 20 : 215)
                .padding(.top , UIScreen.main.bounds.height / 12)
            })
            
        } //: Navigation
        .preferredColorScheme(.dark)
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
