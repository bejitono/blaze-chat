//
//  Theme.swift
//  PHUIKit
//
//  Created by Stefano De Micheli on 25/11/2563 BE.
//

import UIKit

// MARK: - Themeable

public protocol Themeable {
    static var color: ColorThemeable { get }
    static var font: FontThemeable { get }
    static var image: ImageThemeable { get }
}

/// A Theme that will style the UI components in the PHUIKit.
/// Initialize the Theme by providing its dependencies and registering custom fonts upon app start.
public struct Theme: Themeable {
    
    public static var color: ColorThemeable {
        guard let colorTheme = colorTheme else { fatalError("Expected theme to be initialized") }
        return colorTheme
    }
    
    public static var font: FontThemeable {
        guard let fontTheme = fontTheme else { fatalError("Expected theme to be initialized") }
        return fontTheme
    }
    
    public static var image: ImageThemeable {
        guard let imageTheme = imageTheme else { fatalError("Expected theme to be initialized") }
        return imageTheme
    }
    
    private static var colorTheme: ColorThemeable?
    private static var fontTheme: FontThemeable?
    private static var imageTheme: ImageThemeable?
    
    static func initialize(
        colorTheme: ColorThemeable,
        fontTheme: FontThemeable,
        imageTheme: ImageThemeable
    ) {
        self.colorTheme = colorTheme
        self.fontTheme = fontTheme
        self.imageTheme = imageTheme
    }
}

// MARK: - ColorThemeable

public protocol ColorThemeable {
    var primary: UIColor { get }
    var lightPrimary: UIColor { get }
    var secondary: UIColor { get }
    var primaryBackground: UIColor { get }
    var error: UIColor { get }
    var success: UIColor { get }
    var neutral100: UIColor { get }
    var neutral200: UIColor { get }
    var neutral300: UIColor { get }
    var neutral400: UIColor { get }
    var neutral500: UIColor { get }
    var neutral600: UIColor { get }
}

// MARK: - FontThemeable

public protocol FontThemeable {
    var headline3: UIFont { get }
    var headline4: UIFont { get }
    var subtitle1: UIFont { get }
    var subtitle2: UIFont { get }
    var body1: UIFont { get }
    var body2: UIFont { get }
    var caption: UIFont { get }
}

extension FontThemeable {
    
    public static func registerFontWith(bundle: Bundle = .main, name: String, fileExtension: String) {
        guard let url = bundle.url(forResource: name, withExtension: fileExtension) else {
             return assertionFailure("Could not find font file.")
         }
         guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
             print("Could not create font data provider for \(url).")
            return assertionFailure("Could not create font data provider for \(url).")
         }
         guard let font = CGFont(fontDataProvider) else {
             print("could not create font")
            return assertionFailure("Could not create font.")
         }
         var error: Unmanaged<CFError>?
         if !CTFontManagerRegisterGraphicsFont(font, &error) {
             print(error!.takeUnretainedValue())
         }
     }
}

// MARK: - ImageThemeable

public protocol ImageThemeable {
    var checkmark: UIImage { get }
    var delete: UIImage { get }
    var remove: UIImage { get }
    var select: UIImage { get }
}
