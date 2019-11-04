//
//  ViewController.swift
//  WCDBTestDemo
//
//  Created by 边智峰 on 2019/11/4.
//  Copyright © 2019 BabelBank. All rights reserved.
//

import UIKit
import SPDatastorage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        save()
        saveList()
//        delete()
//        get()
        update()
    }

}

//MARK: - 案例
extension ViewController {
    
    
    private func save() {
        let testModel = TestModel(refresh_token: "123", token: "456")
        // 插入, 如果已经存在那么替换(主键相同)
        testModel.insertOrReplace()
    }
    
    // 批量插入
    private func saveList() {
        let list = [TestModel(refresh_token: "123", token: "456"),
                    TestModel(refresh_token: "1233", token: "4564"),
                    TestModel(refresh_token: "1234", token: "4567"),
                    TestModel(refresh_token: "1237", token: "4569"),
                    TestModel(refresh_token: "1239", token: "12341231")]
        list.insertOrReplace()
    }
    
    // orderBy orderList: [OrderBy]? = nil, // 排序的方式 根据某个字段升序/降序
    // limit: Limit? = nil, // 删除的个数
    // offset: Offset? = nil // 从第几个开始删除
    private func delete() {
        // is 精确匹配token为456的数据删除, 这些操作符都是wcdb提供的, 和数据库查表字段含义相同, 根据具体需要使用不同字段
//        TestModel.delete(where: TestModel.Properties.token.is("456"))
        // 如果你想批量删除数据, 可以如下使用. token以456开头
//        TestModel.delete(where: TestModel.Properties.token.like("456%"))
        // 如果你想批量删除数据, 可以如下使用. token包含456
//        TestModel.delete(where: TestModel.Properties.token.like("%456%"))
        // 删除TestModel数据库对应的所有数据
        TestModel.delete()
    }
    
    // orderBy orderList: [OrderBy]? = nil, // 排序的方式 根据某个字段升序/降序
    // limit: Limit? = nil, // 获取的个数
    // offset: Offset? = nil // 从第几个开始获取
    private func get() {
        // 获取表内token包含456的数据
        let results = TestModel.getObjects(where: TestModel.Properties.token.like("%456%"))
        // 获取表内所有数据
//        let results = TestModel.getObjects()
    }
    
    private func update() {
        var result = TestModel.getObjects(where: TestModel.Properties.token.like("%456%"))?.first
        result?.token = "我改了"
        // 这里我现在感觉我原来的写法可能会对使用者造成误解, 如果where为空, 他默认会修改数据库内所有token为要改的字段, wcdb原来写法也是如此, 可能我考虑欠缺了, 总之, 如果想要修改某一条数据, 那么记得写匹配查询语句.
        // 修改token为456的数据的token为我改了
        result?.update(on: [TestModel.Properties.token], where: TestModel.Properties.token.is("456"))
    }
    
}

