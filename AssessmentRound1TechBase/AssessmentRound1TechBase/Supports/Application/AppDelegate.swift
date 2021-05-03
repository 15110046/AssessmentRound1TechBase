//
//  AppDelegate.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit
import FPSCounter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupFpsTracking()
        return true
    }
    
    func setupFpsTracking() {
        FPSCounter.showInStatusBar()
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getFirstScreen()
        window?.makeKeyAndVisible()
        setupFpsTracking()
    }
    
    func getFirstScreen() -> UIViewController {
        return ListMediaViewController.create(modeDisplay: KeyChain.loadSegment(), set: nil)
    }

}
