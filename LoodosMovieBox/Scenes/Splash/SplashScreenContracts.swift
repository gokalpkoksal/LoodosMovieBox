//
//  SplashScreenContracts.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation

protocol SplashScreenDelegate: AnyObject {
    func updateLogoText(text: String)
    func showNoInternetConnectionAlert()
}
