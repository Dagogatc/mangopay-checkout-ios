//
//  File.swift
//  
//
//  Created by Elikem Savie on 10/03/2024.
//

import Foundation

extension Bundle {
    
    private static let core: Bundle = .init(for: PaymentFormView.self)
    
    internal static var mgpInternal: Bundle = {
        let url = core.url(forResource: "MangopayiOSSDK_MangopayCheckoutSDK", withExtension: "bundle")
        let bundle = url.flatMap { Bundle(url: $0) }
        return bundle ?? core
    }()
    
}
