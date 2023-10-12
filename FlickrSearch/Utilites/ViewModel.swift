import Combine
import SwiftUI

// MARK: - ViewModel

/// An object that is responsible for handling actions sent by a view and mutating state based on the actions received.
///
open class ViewModel<Action, State>: ObservableObject {
    // MARK: Properties

    /// The current state for this view model.
    @Published public var state: State

    // MARK: Initialization

    /// Creates a new `ViewModel`.
    ///
    /// - Parameter state: The initial state for this view model.
    public init(state: State) {
        self.state = state
    }

    // MARK: Methods

    /// Creates a `Binding` who's value is derived from the view model's state. When the value is updates, the specified
    /// action is processed by the view model so that the state can be updated.
    ///
    /// - Parameters:
    ///   - get: A closure that provides a value for the binding that is derived from the view model's state.
    ///   - set: A closure that provides a mapping from the binding's value to an action.
    /// - Returns: A `Binding` whose value is set from the view model's state and which triggers an action to be
    ///   processed by the view model when the value changes.
    ///
    public func binding<Value>(
        get: @escaping (State) -> Value,
        set convertValueToAction: @escaping (Value) -> Action
    ) -> Binding<Value> {
        Binding(
            get: { get(self.state) },
            set: { self.receive(convertValueToAction($0)) }
        )
    }

    /// Receives and processes the provided action.
    ///
    /// - Parameter action: The action to process.
    ///
    open func receive(_ action: Action) {}
}
