//
//  DataError.swift
//  GDC-Demo
//
//  Created by TaiHsinLee on 2018/8/31.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import Foundation

enum DataError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invaliedUrl
}
