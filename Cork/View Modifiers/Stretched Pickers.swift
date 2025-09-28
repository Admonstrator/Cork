//
//  Stretched Pickers.swift
//  Cork
//
//  Created by David Bureš - P on 28.09.2025.
//

import Foundation
import SwiftUI

/// Returns the width of pickers to pre-Tahoe styling (fullwidth)
struct StretchedPickersModifier: ViewModifier
{
    
    func body(content: Content) -> some View
    {
        if #available(macOS 26, *)
        {
            return content
                .buttonSizing(.flexible)
        }
        else
        {
            return content
        }
    }
}

extension View
{
    func strechedPickers() -> some View
    {
        return modifier(StretchedPickersModifier())
    }
}
