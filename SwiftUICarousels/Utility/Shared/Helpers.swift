//
//  Helpers.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/26.
//

import Foundation


/// Utilize this class for debug logs extend as seen fit.
class CustomLogger {
    static let shared = CustomLogger()
    
    private init () {}
    
    /// Produces Logs in console only in debug configurations
    func debugLog(_ content: String) {
#if DEBUG
        NSLog("API REQCustomLoggerUEST URL: %@", content)
#endif 
    }
}
