//
//  voiceMemoApp.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/11.
//

import SwiftUI

@main
struct voiceMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
