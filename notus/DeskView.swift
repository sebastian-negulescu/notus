//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

struct DeskView: View {
    var page: PageView
    
    init() {
        self.page = PageView(drawing: PKDrawing())
    }
    
    @State var red_tab_x: CGFloat = 0
    @State var red_tab_offset: CGSize = .zero
    @State var green_tab_x: CGFloat = 0
    @State var green_tab_offset: CGSize = .zero
    @State var blue_tab_x: CGFloat = 0
    @State var blue_tab_offset: CGSize = .zero
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            page
            TabView(colour: .red, content: Text("Hello, world!"))
                .offset(x: (500 + (red_tab_offset.width + red_tab_x)).clamped(to: CGFloat(0)...CGFloat(500)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            red_tab_offset = gesture.translation
                        }
                        .onEnded { gesture in
                            withAnimation(.spring(duration: 0.2, bounce: 0.1)) {
                                let displacement = abs(gesture.predictedEndLocation.x - gesture.startLocation.x)
                                // true is right, false is left
                                let direction = gesture.location.x > gesture.startLocation.x
                                if (displacement > 150) {
                                    if (red_tab_x == -500 && direction) {
                                        red_tab_x = 0
                                    } else if (!direction) {
                                        red_tab_x = -500
                                    }
                                } else {
                                    if (red_tab_x == 0) {
                                        red_tab_x = 0
                                    } else {
                                        red_tab_x = -500
                                    }
                                }
                                red_tab_offset = .zero
                            }
                        }
                )
            TabView(colour: .green, content: Text("Goodbye, world!"))
                .offset(x: (500 + (green_tab_offset.width + green_tab_x)).clamped(to: CGFloat(0)...CGFloat(500)), y: 50)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            green_tab_offset = gesture.translation
                        }
                        .onEnded { gesture in
                            withAnimation(.spring(duration: 0.2, bounce: 0.1)) {
                                let displacement = abs(gesture.predictedEndLocation.x - gesture.startLocation.x)
                                // true is right, false is left
                                let direction = gesture.location.x > gesture.startLocation.x
                                if (displacement > 150) {
                                    if (green_tab_x == -500 && direction) {
                                        green_tab_x = 0
                                    } else if (!direction) {
                                        green_tab_x = -500
                                    }
                                } else {
                                    if (green_tab_x == 0) {
                                        green_tab_x = 0
                                    } else {
                                        green_tab_x = -500
                                    }
                                }
                                green_tab_offset = .zero
                            }
                        }
                )
            TabView(colour: .blue, content: Text("Goodbye, world!"))
                .offset(x: (500 + (blue_tab_offset.width + blue_tab_x)).clamped(to: CGFloat(0)...CGFloat(500)), y: 100)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            blue_tab_offset = gesture.translation
                        }
                        .onEnded { gesture in
                            withAnimation(.spring(duration: 0.2, bounce: 0.1)) {
                                let displacement = abs(gesture.predictedEndLocation.x - gesture.startLocation.x)
                                // true is right, false is left
                                let direction = gesture.location.x > gesture.startLocation.x
                                if (displacement > 150) {
                                    if (blue_tab_x == -500 && direction) {
                                        blue_tab_x = 0
                                    } else if (!direction) {
                                        blue_tab_x = -500
                                    }
                                } else {
                                    if (blue_tab_x == 0) {
                                        blue_tab_x = 0
                                    } else {
                                        blue_tab_x = -500
                                    }
                                }
                                blue_tab_offset = .zero
                            }
                        }
                )
        }
    }
}

#Preview {
    DeskView()
}
