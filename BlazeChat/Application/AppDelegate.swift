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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTheme()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = SeedViewController(seed: [])
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

private extension AppDelegate {
    
    func setupTheme() {
        FontTheme.registerFontWith(name: "Nunito-Regular", fileExtension: "ttf")
        FontTheme.registerFontWith(name: "Nunito-Bold", fileExtension: "ttf")
        Theme.initialize(colorTheme: ColorTheme(), fontTheme: FontTheme(), imageTheme: ImageTheme())
    }
    
    func setupLnd() {
        let cache =  UserCache()
        let password = "12345678"
        LKChannel.shared.start { result in
            guard let user: User = cache.get() else { // TODO: get password from keychain
                LKWallet.shared.generateSeed { result in
                    switch result {
                    case .success(let seed):
                        print(seed)
                    case .failure(let error):
                        print(error)
                    }
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
