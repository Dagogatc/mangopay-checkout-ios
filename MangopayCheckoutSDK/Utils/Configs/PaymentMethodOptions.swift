//
//  File.swift
//  
//
//  Created by Elikem Savie on 01/08/2023.
//

import Foundation

public struct PaymentMethodOptions {
    var cardOptions: MGPCardOptions?

    public init(
        cardOptions: MGPCardOptions
    ) {
        self.cardOptions =  cardOptions
    }
}

