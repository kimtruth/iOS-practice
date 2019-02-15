//
//  ViewController.swift
//  SQLlite3_Test
//
//  Created by truth on 15/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import UIKit

import FMDB

class ViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dbPath = self.getDBPath()
    self.dbExecute(dbPath: dbPath)
  }
  
  private func fmdbTest() -> Bool {
    let db = FMDatabase(path: "test.sqlite")
    if db.open() == false {
      print("Database open error")
      return false
    }
    
    do {
      let command = "INSERT INTO department (depart_title, depaart_addr) VALUES (?, ?)"
      let rs = try db.executeUpdate(command, values: ["인사팀", "301호"])
      
      return true
    } catch let error as NSError {
      print("Insert Error: \(String(describing: error.localizedFailureReason))")
      return false
    }
  }
  
  private func getDBPath() -> String {
    let fileMgr = FileManager()
    let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
    let dbPath = docPathURL?.appendingPathComponent("db.sqlite").path ?? ""
    
    if fileMgr.fileExists(atPath: dbPath) == false{
      let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    
    return dbPath
  }

  private func dbExecute(dbPath: String) {
    var db: OpaquePointer?
    
    let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
    
    if sqlite3_open(dbPath, &db) != SQLITE_OK {
      print("Database Connect Fail")
      return
    }
    defer {
      print("Close Database Connection")
      sqlite3_close(db)
    }
    
    var stmt: OpaquePointer?
    if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK {
      print("Prepare Statement Fail")
      return
    }
    defer {
      print("Finalize Statement")
      sqlite3_finalize(stmt)
    }
    if sqlite3_step(stmt) == SQLITE_DONE {
      print("Create Table Success!")
    }
  }
}

