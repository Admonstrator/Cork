//
//  Package Search Token.swift
//  Cork
//
//  Created by David Bureš on 14.03.2023.
//

import Foundation

enum TokenSearchType
{
    case formula, cask, tap, tag
}

struct PackageSearchToken: Identifiable
{
    var id: String { name }
    var name: String
    var tokenSearchResultType: TokenSearchType
}
