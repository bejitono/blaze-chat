//
//  AppDelegate.swift
//  BlazeChat
//
//  Created by Stefano on 16.01.21.
//

import LightningKit
import LightningKitUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var registrationFlow: RegistrationFlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTheme()
        
        let navigationController = UINavigationController()
        registrationFlow = RegistrationFlowCoordinator(navigationController: navigationController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        startLnd()
        return true
    }
}

private extension AppDelegate {
    
    func setupTheme() {
        FontTheme.registerFontWith(name: "Nunito-Regular", fileExtension: "ttf")
        FontTheme.registerFontWith(name: "Nunito-Bold", fileExtension: "ttf")
        Theme.initialize(colorTheme: ColorTheme(), fontTheme: FontTheme(), imageTheme: ImageTheme())
    }
    
    func startLnd() {
        let cache =  UserCache()
        LKChannel.shared.start { [weak self] result in
            guard let self = self else { return }
            guard let user: User = cache.get() else {
                DispatchQueue.main.async {
                    self.registrationFlow?.start()
                }
                return
            }
            
            // Unlock wallet and start app
            LKWallet.shared.unlock(withPassword: user.password) { (result) in
                print(result)
            }
        }
    }
}
