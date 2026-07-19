//
//  SwiftUICarouselsApp.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 04/05/25.
//

import SwiftUI

@main
struct SwiftUICarouselsApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    let context = persistenceController.container.viewContext
                    switch newPhase {
                    case .active:
                        CustomLogger.shared.debugLog("App is active")
                        Task(priority: .background) {
                            await AppViewModel.shared.fetchFavorites(context: context)
                        }
                    case .inactive:
                        CustomLogger.shared.debugLog("App is inactive")
                    case .background:
                        CustomLogger.shared.debugLog("App moved to background")
                        Task(priority: .background) { 
                            await AppViewModel.shared.saveFavoriteAnime(context: context)
                        }
                    default:
                        break
                    }
                }
        }
    }
}
