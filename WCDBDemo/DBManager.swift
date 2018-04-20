//
//  DBManager.swift
//  AirTalk
//
//  Created by GavinWinner on 2018/3/27.
//  Copyright © 2018年 边智峰. All rights reserved.
//

import UIKit
import WCDBSwift

class DBManager: NSObject {
    
    @objc public static let shared = DBManager()
    private override init() {
        
        let dataBasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/\(userID)/test.db"
        database = Database(withPath: dataBasePath)
    }
    
    var database: Database?
    var userID: Int = 0
    
    /// 创建数据库
    ///
    /// - Parameter withTableName: 要创建的数据库名称
    @objc func creatContactsTable(withTableName: String) {
        do {
            if withTableName == friendsDB {
                try database?.create(table: withTableName, of: FriendModel.self)
            } else {
                try database?.create(table: withTableName, of: ContactModel.self)
            }
        } catch let error {
            print("创建表失败 == \(error)")
        }
    }
    
    /// 插入或替换
    ///
    /// - Parameters:
    ///   - withObject: object 数组
    ///   - propertyConvertibleList: nil
    ///   - tableName: 数据库名
    func insert<Object: TableEncodable>(withObject: [Object], on propertyConvertibleList: [PropertyConvertible]? = nil, tableName: String) {
        do {
            try database?.insertOrReplace(objects: withObject, intoTable: tableName)
        } catch let error {
            print("插入数据失败 == \(error)")
        }
    }
    
    /// 删除联系人
    ///
    /// - Parameters:
    ///   - withModel: 要删除的模型
    ///   - tableName: 数据库名
    func deleteContact(withModel: ContactModel, tableName: String) {
        if withModel.userId == nil {
            return
        }
        do {
            try database?.delete(fromTable: tableName,
                                 where: ContactModel.Properties.userId == withModel.userId!)
        } catch let error {
            print(error)
        }
    }
    
    /// 删除数据库中所有联系人
    ///
    /// - Parameters:
    ///   - tableName: 数据库名
    func deleteAllContacts(tableName: String) {
        do {
            try database?.delete(fromTable: tableName)
        } catch let error {
            print(error)
        }
    }
    
    /// 获取联系人列表
    ///
    /// - Parameter withTableName: 数据库名
    /// - Returns: 联系人列表
    func getAllContacts(withTableName: String) -> [ContactModel]? {
        do {
            let allObjects: [ContactModel]? = try database?.getObjects(fromTable: withTableName)
            return allObjects
        } catch let error {
            print(error)
        }
        return nil
    }
    
    /// 查询有却不完全相等的数据
    ///
    /// - Parameters:
    ///   - withTableName: 数据库名
    ///   - withPhone: 查询条件
    /// - Returns: 模型
    func searchNotLikeContact(withTableName: String, withCondition: String) -> ContactModel? {
        do {
            let Object: ContactModel? = try database?.getObject(fromTable: withTableName,
                                                                where: ContactModel.Properties.nickName.like("%\(withCondition)%") ||
                                                                    ContactModel.Properties.nickName.like("\(withCondition)%") ||
                                                                    ContactModel.Properties.nickName.like("%\(withCondition)") )
            return Object
        } catch let error {
            print(error)
        }
        return nil
    }
    
    
    /// 精确匹配查询
    ///
    /// - Parameters:
    ///   - withTableName: 数据库名
    ///   - withPhone: 查询的属性
    /// - Returns: 模型
    @objc func matchAccurateFriend(withTableName: String, withCondition: String) -> FriendModel? {
        do {
            let Object: ContactModel? = try database?.getObject(fromTable: withTableName,
                                                                where: ContactModel.Properties.nickName.glob("\(withCondition)*"))
            return Object
        } catch let error {
            print(error)
        }
        return nil
    }
    
}
