//
//  ContentView.swift
//  IntermediateSwiftUI
//
//  Created by Sergio Rodríguez Rama on 20/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CustomPropertyWrapperView()
                .tag("custom.property.wrapper")
                .tabItem {
                    Text("P. Wrapper")
                    Image(systemName: "arrow.triangle.2.circlepath.doc.on.clipboard")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
