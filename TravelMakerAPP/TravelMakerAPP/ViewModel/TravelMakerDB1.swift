//
//  TravelMakerDB.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/19/24.
//  searchlist = [searchid(Int), searchname(TEXT), datetime(TEXT)]
//
//
import Foundation
import SQLite3 //<<<

class TM_DB : ObservableObject{
    var db : OpaquePointer?
//    var searchList : [SearchList] = [] // search한 내역저장할 테이블
    
    init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TMDBData.sqlite")
        
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("error opening database")
        }
        //쿼리문
        let create_searchlist = "CREATE TABLE IF NOT EXISTS searchlist (searchid INTEGER PRIMARY KEY AUTOINCREMENT, searchname TEXT, searchdate TEXT)"
        
        
        
        //Table만들기
        if sqlite3_exec(db,create_searchlist, nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMsg)")
        }
        
        
    } //init
    
//    func queryDB_searchList() -> [SearchList] {
//        var stmt : OpaquePointer?
//        let queryString = "SELECT *FROM searchlist"
//        var searchDate : String = ""
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errMsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing select : \(errMsg)")
//        }
//        
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            let searchId = Int(sqlite3_column_int(stmt, 0))
//            let searchName = String(cString: sqlite3_column_text(stmt, 1))
//            // 옵셔널 바인딩을 사용하여 NULL 값을 처리
//            if let datePointer = sqlite3_column_text(stmt, 2) {
//            searchDate = String(cString: datePointer)
//            }
//            searchList.append(SearchList(id: searchId, searchId: searchId, searchName: searchName, searchDate: searchDate))
//        }
//        
//        return searchList
//    }//---
    
    func insertDB_searchList(searchName : String, searchDate : String) -> Bool{
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO searchlist (searchname, searchdate) VALUES (?, ?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert : \(errMsg)")
            return false
        }
        
        sqlite3_bind_text(stmt, 1, (searchName as NSString).utf8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, (searchDate as NSString).utf8String, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error insert data : \(errMsg)")
            return false
        }
    } // ---
    
    //searchList는 update를 날짜만 해준다.
    func updateDB_searchList_date (searchDate : String) -> Bool{
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE searchlist SET searchdate = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, searchDate, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            return true
        }else{
            return false
        }
        
    }
    
    func deleteDB_searchList (searchId: Int32) -> Bool{
        var stmt: OpaquePointer?
                
        let queryString = "DELETE FROM searchlist WHERE searchid = ?"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing delete : \(errMsg)")
            return false
        }
        
        sqlite3_bind_int(stmt, 1, searchId)

        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error delete data : \(errMsg)")
            return false
        }
    }
}
