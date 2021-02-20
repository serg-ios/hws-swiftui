# HWS + Intermediate SwiftUI

Property wrappers, ButtonStyle, ToggleStyle, ProggressViewStyle, LabelStyle...

### Bibliography

https://www.hackingwithswift.com/plus/intermediate-swiftui/creating-a-custom-property-wrapper-using-dynamicproperty

## Creating a custom property wrapper using DynamicProperty

Custom [property wrappers](https://www.hackingwithswift.com/quick-start/swiftui/all-swiftui-property-wrappers-explained-and-compared) can be created.

```swift
@propertyWrapper struct Document {
    @State private var value = ""
    private let url: URL
}
```

It must have a `wrappedValue` property that will change the `@State` value property, the setter is nonmutating because the struct won't be changing. Only the value stored by SwiftUI will be affected.

```swift
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
```

SwiftUI doesn't know that it should be watching property wrapper's changes, until `Document` implements `DynamicProperty`.

```swift
@propertyWrapper struct Document: DynamicProperty
```

It is possible to add a Binding in addition to the wrapped value.

```swift
var projectedValue: Binding<String> {
    Binding(
        get: { wrappedValue },
        set: { wrappedValue = $0 }
    )
}
```

## Basic button customization using ButtonStyle

To create and reuse custom buttons in SwiftUI, button styles can be created.

```swift
struct EmptyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        // Implement this method to return a view.
    }
}
```
