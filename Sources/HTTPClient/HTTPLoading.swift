//
//  HTTPLoading.swift
//  
//
//  Created by Pete Smith on 16/07/2022.
//

import Foundation

/// Abstract interface
public protocol HTTPLoading {

    /// Host URL (i.e base URL)
    var host: String { get }

    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
}
