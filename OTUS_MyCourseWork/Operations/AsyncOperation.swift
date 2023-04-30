//
//  AsyncOperation.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 29.04.2023.
//

import Foundation
open class AsyncOperation: Operation {

    @objc fileprivate enum OperationState: Int {
        case ready
        case executing
        case finished
    }

    /// Concurrent queue for synchronizing access to `state`.
    private let stateQueue = DispatchQueue(label: "AsyncOperation.rw.state", attributes: .concurrent)

    // Private backing stored property for `state`.
    private var _state: OperationState = .ready

    // The state of the operation

    @objc fileprivate dynamic var state: OperationState {
        get {
            return stateQueue.sync {
                _state
            }
        }
        set {
            stateQueue.async(flags: .barrier) {
                self._state = newValue
            }
        }
    }

    // MARK: - Various `Operation` properties

    final override public var isAsynchronous: Bool {
        return true
    }

    open override var isReady: Bool {
        return state == .ready && super.isReady
    }
    public final override var isExecuting: Bool {
        return state == .executing
    }
    public final override var isFinished: Bool {
        return state == .finished
    }

    // KVN for dependent properties

    open override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {

        if ["isReady", "isFinished", "isExecuting"].contains(key) {
            return [#keyPath(state)]
        }

        return super.keyPathsForValuesAffectingValue(forKey: key)
    }

    // Start

    open override func start() {
        if isCancelled {
            state = .finished
            return
        }

        state = .executing
        main()
    }

    /// Subclasses must implement this to perform their work and they must not call `super`.

    open override func main() {
        fatalError("Subclasses must implement `main`.")
    }

    /// Call this function to finish an operation that is currently executing

     public func finish() {
        if isExecuting {
            state = .finished
        }
    }

    override open func cancel() {
        super.cancel()
        if state == .executing {
            state = .finished
        }
    }
}

