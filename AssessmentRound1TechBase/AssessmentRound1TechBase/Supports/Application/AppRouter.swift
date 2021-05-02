//
//  AppRouter.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

open class AppRouter: NSObject {
    
    static let shared: AppRouter = AppRouter()

    public static func presentViewController(
        _ viewController: UIViewController? = nil,
        animated: Bool,
        completion: (() -> Swift.Void)? = nil) {
        guard let viewController = viewController else { return }
        if let topController = self.getVeryTopViewController(){
            topController.present(viewController, animated: animated, completion: completion)
        }
    }

    public static func getVeryTopViewController() -> UIViewController? {
        var topController = self.getRootController()
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    public static func getRootController() -> UIViewController? {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        return rootController
    }
}
