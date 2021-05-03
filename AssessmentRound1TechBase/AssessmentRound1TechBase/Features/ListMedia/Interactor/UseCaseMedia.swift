//
//  UseCase.swift
//  AssessmentRound1TechBase
//
//  Created by Azibai on 03/05/2021.
//  Copyright © 2021 Azibai. All rights reserved.
//

import Foundation

class UseCaseMedia {
    
    func getProviderMedia() -> APIService {
        return MediaService.share
    }
    
    func getLocalService() -> LocalService {
        return LocalService.shared
    }
    
}
