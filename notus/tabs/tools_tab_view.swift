//
//  tools_tab_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI

struct PencilToolView: View {
    
    let colours_info = RadioButtonInfo(
        icon_names: ["circle.fill", "circle.fill", "circle.fill", "circle.fill"],
        icon_colours: [.black, .red, .green, .blue],
        dimensions: CGSize(width: 20, height: 20),
        padding: 4,
        selected_colour: .blue,
        selected_weight: 3)
    @State var colour_selected = 0
    
    @State var stroke_weight = 0.5
    
    var body: some View {
        VStack {
            Image(systemName: "pencil.tip")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            
            Text("Colour")
            RadioButtons(info: colours_info, selected: $colour_selected)
            
            Spacer()
            
            Text("Weight")
            HStack {
                Slider(value: $stroke_weight, in: 0.1...1, step: 0.1)
                Text("\(stroke_weight.formatted(.number.precision(.fractionLength(1))))mm")
                    .monospaced()
            }
            
            Spacer()
        }
        .padding(20)
        .frame(width: 180, height: 300)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 2))
    }
}

struct EraserToolView: View {
    
    let type_info = RadioButtonInfo(
        icon_names: ["circle", "x.circle"],
        icon_colours: [.black, .black],
        dimensions: CGSize(width: 20, height: 20),
        padding: 4,
        selected_colour: .blue,
        selected_weight: 3)
    @State var type_selected = 0

    @State var diameter = 1.0
    
    var body: some View {
        VStack {
            Image(systemName: "eraser")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            VStack {
                Text("Type: \(type_selected == 0 ? "Pixel" : "Stroke")")
                RadioButtons(info: type_info, selected: $type_selected)
                Text("Diameter")
                HStack {
                    Slider(value: $diameter, in: 0.1...5, step: 0.1)
                        .disabled(type_selected != 0)
                    Text("\(diameter.formatted(.number.precision(.fractionLength(1))))cm")
                        .monospaced()
                }
            }
            Spacer()
            
        }
        .padding(20)
        .frame(width: 180, height: 300)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 2))
    }
}

struct ToolsTabView: View {
    let tab_offset: UInt
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
    }
    
    var content: some View {
        HStack {
            VStack {
                Text("Primary")
                    .font(.title2)
                PencilToolView()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            Rectangle()
                .fill(.black)
                .frame(width: 2, height: 400)
            VStack {
                Text("Secondary")
                    .font(.title2)
                EraserToolView()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
        }
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .green, content: content)
    }
}

#Preview {
    ToolsTabView(tab_offset: 0)
        .offset(x: -500)
}
