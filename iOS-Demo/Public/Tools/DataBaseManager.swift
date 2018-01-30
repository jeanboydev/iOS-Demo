//
//  DataBaseManager.swift
//
//  Created by jeanboy on 2017/12/14.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseManager {
    
    /* Realm 数据库配置，用于数据库的迭代更新 */
    private static let schemaVersion: UInt64 = 0
    
    //单例
    static let shared: DataBaseManager = DataBaseManager()
    
    // 私有化构造函数
    private init() {
    }
    
    func setup(){
        var documentsURL = FolderUtil.getDocumentURL(path: AppFolder.database)
        documentsURL.appendPathComponent("default.realm", isDirectory: false)
        
        let config = Realm.Configuration(fileURL: documentsURL, schemaVersion: DataBaseManager.schemaVersion, migrationBlock: { migration, oldSchemaVersion in
            //什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
            if (oldSchemaVersion < DataBaseManager.schemaVersion) {
                
            }
        })
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {//Realm 成功打开，迁移已在后台线程中完成
                debugPrint("===Realm===> 数据库配置成功")
            } else if let error = error {//处理打开 Realm 时所发生的错误
                debugPrint("===Realm===> 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }
    
    private lazy var realm = try! Realm()
    
    ///
    /// 添加数据
    ///
    /// - Parameter object: Element
    func add(object: Object){
        try! realm.write {
            realm.add(object)
        }
    }
    
    /// 添加多条数据
    ///
    /// - Parameter objects: List<Element>
    func add<Element: Object>(objects: List<Element>){
        try! realm.write {
            realm.add(objects)
        }
    }
    
    /// 在事务中添加
    ///
    /// - Parameter object: Element
    func addInTransaction(object: Object){
        realm.add(object)
    }
    
    /// 在事务中添加多条数据
    ///
    /// - Parameter objects: List<Element>
    func addInTransaction<Element: Object>(objects: List<Element>){
        realm.add(objects)
    }
    
    /// 删除数据
    ///
    /// - Parameter object: Element
    func delete(object: Object){
        try! realm.write {
            realm.delete(object)
        }
    }
    
    /// 删除多条数据
    ///
    /// - Parameter objects: List<Element>
    func delete<Element: Object>(objects: List<Element>){
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    /// 删除数据库中所有数据
    func clear(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    /// 修改数据
    ///
    /// - Parameters:
    ///   - object: Element
    ///   - onUpdate: 更新回调处理
    func update<Element: Object>(object: Element, onUpdate: (_ obj: Element) -> ()){
        try! realm.write {
            onUpdate(object)
        }
    }
    
    /// 查询所有数据
    ///
    /// - Parameters:
    ///   - type: Element.Type
    ///   - onResult: 查询结果回调
    func getAll<Element: Object>(type: Element.Type, onResult: (_ results:Results<Element>) -> ()){
        try! realm.write {
            //realm.objects(type).filter().sorted(byKeyPath: "name", ascending: false)//可以按条件筛选
            onResult(realm.objects(type))
        }
    }
    
    /// 根据主键查询数据
    ///
    /// - Parameters:
    ///   - type: Element.Type
    ///   - key: key
    ///   - onResult: 查询结果回调
    func getByPrimaryKey<Element: Object>(type: Element.Type, key:String, onResult: (_ result:Element?) -> ()){
        try! realm.write {
            onResult(realm.object(ofType: type, forPrimaryKey: key))
        }
    }
}
