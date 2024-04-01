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
    var searchList : [SearchList] = [] // search한 내역저장할 테이블
    var planGroup : [PlanGroup] = []
    var planDetail : [PlanDetail] = []
    
    init(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TMDBData.sqlite")
        
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("error opening database")
        }
//쿼리문
        
        let create_searchlist = "CREATE TABLE IF NOT EXISTS searchlist (searchid INTEGER PRIMARY KEY AUTOINCREMENT, searchname TEXT, searchdate TEXT)"
        //
        let create_plangroup = "CREATE TABLE IF NOT EXISTS plangroup (groupid INTEGER PRIMARY KEY AUTOINCREMENT, grouptitle TEXT, groupfriend TEXT, groupcolor INTEGER, groupcompletestatus TINYINT, groupstartdate TEXT, groupenddate TEXT)"
        let create_plandetail = "CREATE TABLE IF NOT EXISTS plandetail (planid INTEGER PRIMARY KEY AUTOINCREMENT, pgid INTEGER, plantitle TEXT, planmemo TEXT, planrating INTEGER)"
//Table만들기
//serarchList테이블
        if sqlite3_exec(db,create_searchlist, nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating searchListTable: \(errMsg)")
        }
//planGroup테이블
        if sqlite3_exec(db,create_plangroup, nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating planGroupTable: \(errMsg)")
        }
//planDetail테이블
        if sqlite3_exec(db, create_plandetail, nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error create planDetailTable \(errMsg)")
        }
        
    } //init
/// ===================DB SELECT===================
//SearchList 조회
    func queryDB_searchList() -> [SearchList] {
        var stmt : OpaquePointer?
        let queryString = "SELECT * FROM searchlist"
        var searchDate : String = ""
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing searchList : \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let searchId = Int(sqlite3_column_int(stmt, 0))
            let searchName = String(cString: sqlite3_column_text(stmt, 1))
            // 옵셔널 바인딩을 사용하여 NULL 값을 처리
            if let datePointer = sqlite3_column_text(stmt, 2) {
                searchDate = String(cString: datePointer)
            }
            searchList.append(SearchList(id: searchId, searchId: searchId, searchName: searchName, searchDate: searchDate))
        }
        
        return searchList
    }// SELECT searchList
// planGroup 조회
    func queryDB_planGroup() -> [PlanGroup] {
        var stmt : OpaquePointer?
        let queryString = "SELECT * FROM plangroup"
        var groupFriend : String = ""
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing planGroup : \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let groupId = Int(sqlite3_column_int(stmt, 0))
            let groupTitle = String(cString: sqlite3_column_text(stmt, 1))
            if let friendPointer = sqlite3_column_text(stmt, 2){
                groupFriend = String(cString: friendPointer)
            }
            let groupColor = Int(sqlite3_column_int(stmt, 3))
            let groupCompleteStatus = Int(sqlite3_column_int(stmt, 4))
            let groupStartDate = String(cString: sqlite3_column_text(stmt, 5))
            let groupEndDate = String(cString: sqlite3_column_text(stmt, 6))
            
            planGroup.append(PlanGroup(id: groupId, groupId: groupId, groupTitle: groupTitle, groupFriend: groupFriend, groupColor: groupColor, groupCompleteStatus: groupCompleteStatus, groupStartDate: groupStartDate, groupEndDate: groupEndDate))
        }
        return planGroup
        
    }//Select plangroup

//planDetail 조회
    func queryDB_planDetail() -> [PlanDetail] {
        var stmt : OpaquePointer?
        let queryString = "SELECT * From plandetail"
        var planMemo : String = ""
        var planRating : Int? = nil
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing planDetail : \(errMsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let planId = Int(sqlite3_column_int(stmt, 0))
            let pgId = Int(sqlite3_column_int(stmt, 1))
            let planTitle = String(cString : sqlite3_column_text(stmt, 2))
            if let planMemoPointer = sqlite3_column_text(stmt, 3){
                planMemo = String(cString: planMemoPointer)
            }
            if sqlite3_column_int(stmt, 4) != SQLITE_NULL{
                planRating = Int(sqlite3_column_int(stmt, 4))
            }else{
                planRating = nil
            }
            planDetail.append(PlanDetail(id: planId, planId: planId, pgId: pgId, planTitle: planTitle, planMemo: planMemo, planRating: planRating))
        }
        return planDetail
    }
    
    
/// ===================DB INSERT===================
    //SearchList Insert
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
    } // Insert searchList
    
    //planGroup Insert
    func insertDB_planGroup(groupTitle : String, groupFriend : String?, groupColor : Int, groupCompleteStatus : Int, groupStartDate : String, groupEndDate : String) -> Bool{
        
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        var queryString: String
        var bindIndex: Int32
        
        if let friend = groupFriend {
            queryString = "INSERT INTO plangroup (groupTitle, groupFriend, groupColor, groupCompleteStatus, groupStartDate, groupEndDate) VALUES (?, ?, ?, ?, ?, ?)"
            bindIndex = 1 // groupTitle
            // Bind groupFriend value
            sqlite3_bind_text(stmt, 2, (friend as NSString).utf8String, -1, SQLITE_TRANSIENT)
        } else {
            queryString = "INSERT INTO plangroup (groupTitle, groupColor, groupCompleteStatus, groupStartDate, groupEndDate) VALUES (?, ?, ?, ?, ?)"
            bindIndex = 1 // groupTitle
        }
        
        // Prepare the statement
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errMsg)")
            return false
        }
        
        // Bind other parameters
        sqlite3_bind_text(stmt, bindIndex, (groupTitle as NSString).utf8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(stmt, bindIndex + 1, Int32(groupColor))
        sqlite3_bind_int(stmt, bindIndex + 2, Int32(groupCompleteStatus))
        sqlite3_bind_text(stmt, bindIndex + 3, (groupStartDate as NSString).utf8String, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, bindIndex + 4, (groupEndDate as NSString).utf8String, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error insert data: \(errMsg)")
            return false
        }
    }
    
    //planDetail
    func insertDB_planDetail(planId: Int, pgId: Int, planTitle: String, planMemo: String?, planRating: Int?) -> Bool {
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO plandetail (planId, pgId, planTitle, planMemo, planRating) VALUES (?, ?, ?, ?, ?)"
        
        // Prepare the statement
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errMsg)")
            return false
        }
        
        sqlite3_bind_int(stmt, 1, Int32(planId))
        sqlite3_bind_int(stmt, 2, Int32(pgId))
        sqlite3_bind_text(stmt, 3, (planTitle as NSString).utf8String, -1, SQLITE_TRANSIENT)
        
        // planMemo가 있을 때
        if let memo = planMemo {
            sqlite3_bind_text(stmt, 4, (memo as NSString).utf8String, -1, SQLITE_TRANSIENT)
        } else {
            sqlite3_bind_null(stmt, 4)
        }
        
        // planRating이 있을 때
        if let rating = planRating {
            sqlite3_bind_int(stmt, 5, Int32(rating))
        } else {
            sqlite3_bind_null(stmt, 5)
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error insert data: \(errMsg)")
            return false
        }
    }

    
/// ===================DB UPDATE===================
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
/// ===================DB DELETE===================
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

