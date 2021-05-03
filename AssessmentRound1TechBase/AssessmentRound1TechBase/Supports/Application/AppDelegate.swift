//
//  AppDelegate.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit
import FPSCounter

let showFPS = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupFpsTracking()
        return true
    }
    
    func setupFpsTracking() {
        if showFPS {
            FPSCounter.showInStatusBar()
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getFirstScreen()
        window?.makeKeyAndVisible()
        setupFpsTracking()
    }
    
    func getFirstScreen() -> UIViewController {
        return ListMediaViewController.create()
    }

}
