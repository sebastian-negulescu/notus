//
//  paper_tab_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI

struct PaperTabView: View {
    let tab_offset: UInt
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
    }

    @State var spacing: CGFloat = 50.0
    @State var weight: CGFloat = 1.0
    
    let pattern_info = RadioButtonInfo(
        icon_names: ["circle", "equal.circle", "square.circle", "circle.grid.3x3.circle", "circle.hexagongrid.circle"],
        icon_colours: [.black, .black, .black, .black, .black],
        dimensions: CGSize(width: 40, height: 40),
        padding: 8,
        selected_colour: .blue,
        selected_weight: 3)
    @State var pattern_selected = 0
    
    let colours_info = RadioButtonInfo(
        icon_names: ["circle", "circle.fill", "circle.fill"],
        icon_colours: [.black, .black, Color(red: 251/255, green: 241/255, blue: 199/255)],
        dimensions: CGSize(width: 40, height: 40),
        padding: 8,
        selected_colour: .blue,
        selected_weight: 3)
    let colours_map = [.white, .black, Color(red: 251/255, green: 241/255, blue: 199/255)]
    @State var colour_selected = 0
    
    var content: some View {
        VStack {
            HStack {
                Text("Pattern")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                RadioButtons(info: pattern_info, selected: $pattern_selected)
                Spacer()
            }
            HStack {
                Text("Spacing")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                Slider(value: $spacing, in: 25...75)
                    .frame(maxWidth: 300)
                Spacer()
            }
            HStack {
                Text("Weight")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                Slider(value: $weight, in: 0.1...10)
                    .frame(maxWidth: 300)
                Spacer()
            }
            HStack {
                Text("Colour")
                    .font(.title2)
                    .frame(minWidth: 100, alignment: .leading)
                RadioButtons(info: colours_info, selected: $colour_selected)
                Spacer()
            }
            Spacer()
            Canvas { context, size in
                fill_background(&context, size,
                                background_info: BackgroundInfo(spacing: spacing,
                                                                weight: weight,
                                                                background_colour: colours_map[colour_selected],
                                                                pattern_colour: colours_map[colour_selected] == .black ? .white : .black,
                                                                pattern: Pattern(rawValue: pattern_selected)!))
            }
                .border(.black)
            Spacer()
            HStack {
                Button(action: do_nothing) {
                    Text("Apply current")
                }
                .buttonStyle(.bordered)
                Button(action: do_nothing) {
                    Text("Apply all")
                }
                .buttonStyle(.bordered)
                Button(action: do_nothing) {
                    Text("Discard")
                    .foregroundStyle(.red)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(20)
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .blue, content: content)
    }
}

#Preview {
    PaperTabView(tab_offset: 0)
}
