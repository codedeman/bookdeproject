//
//  Coordinator.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//


import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
