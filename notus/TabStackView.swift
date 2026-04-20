//
//  TabStackView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-15.
//

import System
import SwiftUI
import PencilKit

struct InfoTabView: View {
    let tab_offset: UInt
    
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
        
        self.date_formatter.dateFormat = "dd-MM-YYYY"
    }
    
    let name: String = "Placeholder"
    let location: FilePath = "/path/to/Placeholder"
    let date_created: Date = Date()
    let date_formatter = DateFormatter()
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                Text(location.string)
                Text(date_formatter.string(from: date_created))
                
                Spacer()
                
                HStack {
                    Button(action: do_nothing) {
                        Label("File away", systemImage: "arrowshape.turn.up.backward")
                    }
                    .buttonStyle(.bordered)
                    Button(action: do_nothing) {
                        Label("Export", systemImage: "tray.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    Button(action: do_nothing) {
                        Label("Delete", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.all, 20)
            Spacer()
        }
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .red, content: content)
    }
}

struct PencilToolView: View {
    @State var stroke_weight = 50.0
    var body: some View {
        VStack {
            Image(systemName: "pencil.and.scribble")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            
            Text("Colour")
            HStack {
                Image(systemName: "circle.fill")
                Image(systemName: "circle.circle.fill")
                Image(systemName: "circle.fill")
            }
            .padding(1)
            HStack {
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
                Image(systemName: "plus.circle")
            }
            .padding(1)
            
            Spacer()
            
            Text("Weight")
            HStack {
                Image(systemName: "scribble")
                    .fontWeight(.ultraLight)
                Image(systemName: "scribble")
                    .fontWeight(.light)
                Image(systemName: "scribble")
                    .fontWeight(.medium)
                Image(systemName: "scribble")
                    .fontWeight(.bold)
                Image(systemName: "scribble")
                    .fontWeight(.black)
            }
            .padding(1)
            
            Spacer()
        }
        .padding(20)
        .frame(width: 160, height: 300)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 2))
    }
}

struct EraserToolView: View {
    var body: some View {
        VStack {
            Image(systemName: "eraser")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.bottom, 20)
            Text("Size")
            HStack {
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                Image(systemName: "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Image(systemName: "x.square.fill")
            }
            Spacer()
            
        }
        .padding(20)
        .frame(width: 160, height: 300)
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

enum Pattern {
    case Blank
    case Line
    case Grid
    case Dot
    case Iso
}

func generate_pattern(pattern: Pattern, size: CGSize, spacing: CGFloat) -> Path {
    var path = Path()
    
    switch (pattern) {
    case .Line:
        for y in stride(from: 0, through: size.height, by: spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
    case .Grid:
        for x in stride(from: 0, through: size.width, by: spacing) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
        }
        for y in stride(from: 0, through: size.height, by: spacing) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
    case .Dot:
        let dot_size: CGFloat = 1.0
        for x in stride(from: spacing, through: size.width, by: spacing) {
            for y in stride(from: spacing, through: size.height, by: spacing) {
                let rect = CGRect(x: x - (dot_size / 2),
                                  y: y - (dot_size / 2),
                                  width: dot_size,
                                  height: dot_size)
                path.addEllipse(in: rect)
            }
        }
    case .Iso:
        let dot_size: CGFloat = 1.0
        var even = true
        let line_height = sqrt((spacing * spacing - spacing * spacing / 4))
        for y in stride(from: spacing / 2, through: size.height, by: line_height) {
            for x in stride(from: even ? spacing : spacing / 2, through: size.width, by: spacing) {
                let rect = CGRect(x: x - (dot_size / 2),
                                  y: y - (dot_size / 2),
                                  width: dot_size,
                                  height: dot_size)
                path.addEllipse(in: rect)
            }
            even = !even
        }
    default:
        break
    }
    
    return path
}

struct PaperTabView: View {
    let tab_offset: UInt
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
    }
    
    @State var pattern: Pattern = .Iso
    @State var spacing: CGFloat = 50.0
    @State var background: Color = .white
    
    var content: some View {
        VStack {
            HStack {
                Text("Pattern")
                    .font(.title2)
                Image(systemName:"circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                Image(systemName: "equal.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                Image(systemName: "square.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 3)
                    )
                Image(systemName: "circle.grid.3x3.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                Image(systemName: "circle.hexagongrid.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                Spacer()
            }
            HStack {
                Text("Spacing")
                    .font(.title2)
                Spacer()
                Slider(value: $spacing, in: 0...100, step: 1)
                Spacer()
            }
            HStack {
                Text("Colour")
                    .font(.title2)
                Image(systemName:"circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 3)
                    )
                Image(systemName:"circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                    .foregroundStyle(.black)
                Image(systemName:"circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .overlay(
                        Circle()
                            .stroke(Color.clear, lineWidth: 3)
                    )
                    .foregroundStyle(Color(red: 251/255, green: 241/255, blue: 199/255))
                Spacer()
            }
            Spacer()
            Canvas { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(background))
                let pattern_path = generate_pattern(pattern: pattern, size: size, spacing: spacing)
                context.stroke(pattern_path, with: .color(.black))
            }
                .frame(width: 150, height: 200)
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

struct TabStackView: View {
    var body: some View {
        ZStack (alignment: .topTrailing) {
            InfoTabView(tab_offset: 0)
            ToolsTabView(tab_offset: 1)
            PaperTabView(tab_offset: 2)
        }
    }
}

#Preview {
    PaperTabView(tab_offset: 0)
        .offset(x: -500)
}
