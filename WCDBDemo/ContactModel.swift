//
//  ContactModel.swift
//  AirTalk
//
//  Created by GavinWinner on 2018/1/6.
//  Copyright © 2018年 边智峰. All rights reserved.
//

import UIKit
import Contacts
import ObjectMapper
import WCDBSwift

class ContactModel: NSObject, Mappable, TableCodable {

    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nickname  <- map["nickname"]
        userId    <- map["userId"]
    }
    
    var nickname: String? = nil
    var userId: Int? = nil
    
   
    /// 绑定模型
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ContactModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case nickname
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                nickname: ColumnConstraintBinding(isNotNull: true, defaultTo: ""), //设置是否可以为空
                userId: ColumnConstraintBinding(isPrimary: true) //作为主键
            ]
        }
        
        static var virtualTableBinding: VirtualTableBinding? {
            return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .Apple))
        }
    }
    
    //Properties below are needed only the primary key is auto-incremental
    var isAutoIncrement: Bool = false
    var lastInsertedRowID: Int64 = 0
}



