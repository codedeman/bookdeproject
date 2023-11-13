//
//  File.swift
//  
//
//  Created by Kevin on 11/14/23.
//

import Foundation
import Combine

public final class NewMessageViewModel: ObservableObject {

    private var usecase: MessageUseCase

    public init(usecase: MessageUseCase) {
        self.usecase = usecase
    }



}
