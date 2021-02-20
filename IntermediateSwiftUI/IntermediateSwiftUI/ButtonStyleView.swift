//
//  ButtonStyleView.swift
//  IntermediateSwiftUI
//
//  Created by Sergio Rodríguez Rama on 20/2/21.
//

import SwiftUI

struct EmptyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct ColoredButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

struct StripedRectangleButtonStyle: ButtonStyle {
    var offColor = Color.blue
    var onColor = Color.green

    func color(for configuration: Configuration) -> Color {
        configuration.isPressed ? onColor : offColor
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Rectangle()
                .fill(color(for: configuration))
                .frame(width: 10)
            configuration.label
                .padding()
                .foregroundColor(color(for: configuration))
                .textCase(.uppercase)
                .font(Font.title.bold())
                .border(color(for: configuration), width: 4)
        }
        .fixedSize()
        .animation(nil)
    }
}

struct PushButtonStyle: ButtonStyle {
    let lightGray = Color(white: 0.8)

    func makeBody(configuration: Configuration) -> some View {
        let startEdge: UnitPoint
        let endEdge: UnitPoint

        if configuration.isPressed {
            startEdge = UnitPoint.bottomTrailing
            endEdge = UnitPoint.topLeading
        } else {
            startEdge = UnitPoint.topLeading
            endEdge = UnitPoint.bottomTrailing
        }

        return configuration.label
            .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.7 : 1))
            .font(.largeTitle)
            .padding(40)
            .background(
                LinearGradient(gradient: Gradient(colors: [lightGray, .white]), startPoint: startEdge, endPoint: endEdge)
            )
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [.white, lightGray]), startPoint: startEdge, endPoint: endEdge),
                        lineWidth: 16
                    )
                    .padding(2)
                    .overlay(
                        Circle()
                            .stroke(configuration.isPressed ? Color.black : Color.gray, lineWidth: 1)
                    )
            )
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 10, x: 10, y: 10)
            .animation(nil)
    }
}

struct ButtonStyleView: View {
    var body: some View {
        VStack(spacing: 50) {

            Button {
                print("Pressed")
            } label: {
                Text("Try it free")
            }
            .buttonStyle(ColoredButtonStyle(color: .blue))

            Button {
                print("Pressed")
            } label: {
                Text("Try it free")
            }
            .buttonStyle(StripedRectangleButtonStyle())

            Button {
                print("Pressed")
            } label: {
                Image(systemName: "star")
            }
            .buttonStyle(PushButtonStyle())
        }
    }
}

struct ButtonStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleView()
    }
}
