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
                    switch newPhase {
                    case .active:
                        print("App is active")
                        Task(priority: .background) { 
                            let context = persistenceController.container.viewContext
                            await AppViewModel.shared.fetchFavorites(context: context)
                        }
                    case .inactive:
                        print("App is inactive")
                    case .background:
                        print("App moved to background")
                        Task(priority: .background) { 
                            let context = persistenceController.container.viewContext
                            await AppViewModel.shared.saveFavoriteAnime(context: context)
                        }
                    default:
                        break
                    }
                }
        }
    }
}
