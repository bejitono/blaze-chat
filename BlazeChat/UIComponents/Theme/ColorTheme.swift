//
//  ColorTheme.swift
//  PHWallet
//
//  Created by Stefano De Micheli on 4/1/21.
//  Copyright © 2021 OPN Tech Co., Ltd. All rights reserved.
//

import UIKit

// swiftlint:disable discouraged_object_literal
struct ColorTheme: ColorThemeable {
    let primary: UIColor = #colorLiteral(red: 0.8470588235, green: 0.1490196078, blue: 0.3843137255, alpha: 1)
    let lightPrimary: UIColor = #colorLiteral(red: 0.8470588235, green: 0.1490196078, blue: 0.3843137255, alpha: 0.3915881849)
    let secondary: UIColor = #colorLiteral(red: 0.1843137255, green: 0.5019607843, blue: 0.9294117647, alpha: 1)
    let primaryBackground: UIColor = #colorLiteral(red: 0.9411764706, green: 0.9529411765, blue: 0.9647058824, alpha: 1)
    let error: UIColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
    let success: UIColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
    let neutral100: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    let neutral200: UIColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
    let neutral300: UIColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    let neutral400: UIColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    let neutral500: UIColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    let neutral600: UIColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
}
