//
//  CustomPropertyWrapperView.swift
//  IntermediateSwiftUI
//
//  Created by Sergio Rodríguez Rama on 20/2/21.
//

import SwiftUI

@propertyWrapper struct Document: DynamicProperty {
    @State private var value = ""

    private let url: URL

    var wrappedValue: String {
        get {
            value
        }

        nonmutating set {
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch {
                print("Failed to write output")
            }
        }
    }

    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    init(_ fileName: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        url = paths[0].appendingPathComponent(fileName)

        let initialText = (try? String(contentsOf: url)) ?? ""
        _value = State(wrappedValue: initialText)
    }
}


struct CustomPropertyWrapperView: View {

    @Document("test.txt") var document

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $document)
                Button("Change document") {
                    document = String(Int.random(in: 1...1000))
                }
                .padding()
            }
            .navigationTitle("SimpleText")
        }
    }
}

struct CustomPropertyWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPropertyWrapperView()
    }
}
