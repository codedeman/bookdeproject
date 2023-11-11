//
//  StateManager.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import Combine
import SwiftUI

public protocol StateManager: Hashable { }

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()

    public init() {}

    public func presentSheet(destination: any Identifiable) {
    }

    public func navigate(to destination: any StateManager) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
