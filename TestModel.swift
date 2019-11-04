//
//  TestModel.swift
//  WCDBTestDemo
//
//  Created by 边智峰 on 2019/11/4.
//  Copyright © 2019 BabelBank. All rights reserved.
//

import Foundation
import SPDatastorage
import WCDBSwift
import HandyJSON

struct TestModel: HandyJSON, CZBDbManagerProtocol, TableCodable {
    
    var refresh_token: String?
    var token: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = TestModel
        static let objectRelationalMapping =
            TableBinding(CodingKeys.self)
        case token
        case refresh_token

        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                refresh_token: ColumnConstraintBinding(isPrimary: true, isNotNull: true, defaultTo: "0")
            ]
        }
    }

    var isAutoIncrement: Bool = false // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}
