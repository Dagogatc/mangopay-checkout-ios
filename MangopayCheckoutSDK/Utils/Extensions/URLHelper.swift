//
//  File.swift
//  
//
//  Created by Elikem Savie on 12/11/2022.
//

import Foundation


protocol URLHelping {

    func urlsMatch(redirectUrl: URL, matchingUrl: URL) -> Bool
    func extract3DSResult(from url: URL, type: _3DSTransactionType?) -> _3DSResult?
    func extractPreAuth(from url: URL, queryKey: String) -> String?
}

final class URLHelper: URLHelping {

    func extract3DSResult(from url: URL, type: _3DSTransactionType?) -> _3DSResult? {

        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }

        let statusStr = components.queryItems?.first { $0.name == "status" }?.value ?? "FAILED"
        
        if let _type = type {
            guard let id = components.queryItems?.first(where: { $0.name == _type.id })?.value else { return nil }
            return _3DSResult(
                type: _type,
                status: _3DSStatus(rawValue: statusStr) ?? .FAILED,
                id: id
            )
        } else {
            for type in _3DSTransactionType.allCases {
                guard let id = components.queryItems?.first(where: { $0.name == type.id })?.value else { continue }
                return _3DSResult(
                    type: type,
                    status: _3DSStatus(rawValue: statusStr) ?? .FAILED,
                    id: id
                )
            }

            return nil
        }
        

    }

    func extractPreAuth(from url: URL, queryKey: String) -> String? {

        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }

        return components.queryItems?.first { $0.name == queryKey }?.value
    }

    func urlsMatch(redirectUrl: URL, matchingUrl: URL) -> Bool {

        guard let redirectURLComponents = URLComponents(url: redirectUrl, resolvingAgainstBaseURL: false),
              let matchingURLComponents = URLComponents(url: matchingUrl, resolvingAgainstBaseURL: false) else {
            return false
        }

        if let matchingQueryItems = matchingURLComponents.queryItems {
            for matchingItem in matchingQueryItems {

                let queryItemIsPresent = redirectURLComponents.queryItems?.contains(where: {
                    matchingItem.name == $0.name && matchingItem.value == $0.value
                }) ?? false

                guard queryItemIsPresent else {
                    return false
                }
            }
        }

        return redirectURLComponents.scheme == matchingURLComponents.scheme
            && redirectURLComponents.host == matchingURLComponents.host
            && redirectURLComponents.path == matchingURLComponents.path
            && redirectURLComponents.fragment == matchingURLComponents.fragment
    }
}
