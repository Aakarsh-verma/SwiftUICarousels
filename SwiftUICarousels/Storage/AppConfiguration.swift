//
//  AppConfiguration.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/07/26.
//

import Foundation

enum AppConfiguration {
    static var malClientID: String {
        guard let clientID = Bundle.main.object(
            forInfoDictionaryKey: "MALClientID"
        ) as? String,
        !clientID.isEmpty,
        clientID != "$(MAL_CLIENT_ID)" else {
            fatalError(
                "MAL_CLIENT_ID is missing. Configure Secrets.xcconfig."
            )
        }

        return clientID
    }
}
