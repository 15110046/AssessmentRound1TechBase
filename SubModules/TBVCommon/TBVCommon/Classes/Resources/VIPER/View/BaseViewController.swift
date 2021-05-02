//
//  BaseViewController.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 28/04/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    //MARK: Properties
    public var hidesNavigationbar:              Bool = false
    public var hidesToolbar:                    Bool = false
    public var viewDidAppearCount:              Int  = -1
    public var isAppearOnScreen:                Bool = false
    
    //MARK: Method
    
    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle.init(for: Self.self))
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUIVariable() {
        
    }
    
    open func setCurrentNavigationVariable() {
    self.navigationController?.setNavigationBarHidden(self.hidesNavigationbar, animated: false)
        self.navigationController?.setToolbarHidden(self.hidesToolbar, animated: false)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initUIVariable()
    }
        
    open override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         self.viewDidAppearCount += 1
         self.isAppearOnScreen = true
     }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isAppearOnScreen = true
        self.setCurrentNavigationVariable()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isAppearOnScreen = false
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isAppearOnScreen = false
    }

}

