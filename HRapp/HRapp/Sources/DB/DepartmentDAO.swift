//
//  DepartmentDAO.swift
//  HRapp
//
//  Created by truth on 15/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import Foundation

import FMDB

class DepartMentDAO {
  /// 부서 정보를 담을 튜플 타입 정의
  typealias DepartRecord = (Int, String, String)
  
  /// SQLite 연결 및 초기화
  lazy var fmdb: FMDatabase! = {
    /// 1. 파일 매니저 객체를 생성
    let fileMgr = FileManager.default
    
    /// 2. 샌드박스 내 문서 디렉터리에서 데이터베이스 파일 경로를 확인
    let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
    let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
    
    /// 3. 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite를 가져와 복사
    if fileMgr.fileExists(atPath: dbPath) == false {
      let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
      try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
    }
    
    /// 4. 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
    let db = FMDatabase(path: dbPath)
    return db
  }()
  
  
  // MARK: Initializing
  
  init() {
    self.fmdb.open()
  }
  
  deinit {
    self.fmdb.close()
  }
  
  // MARK: Functions
  
  func find() -> [DepartRecord] {
    /// 반환될 데이터를 담을 [DepartRecord] 타입의 객체 정의
    var departList = [DepartRecord]()
    
    do {
      let sql = """
        SELECT depart_cd, depart_title, depart_addr
        FROM department
        ORDER BY depart_cd ASC
      """
      
      let rs = try self.fmdb.executeQuery(sql, values: nil)
      
      /// 2.결과 집합 추출
      while rs.next() {
        let departCd = rs.int(forColumn: "depart_cd")
        let departTitle = rs.string(forColumn: "depart_title")
        let departAddr = rs.string(forColumn: "depart_addr")
        
        /// append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의
        departList.append( (Int(departCd), departTitle!, departAddr!) )
      }
    } catch let error {
      print("failed: \(error.localizedDescription)")
    }
    return departList
  }
  
  func get(departCd: Int) -> DepartRecord? {
    /// 1. 질의 실행
    let sql = """
      SELECT depart_cd, depart_title, depart_addr
      FROM department
      WHERE depart_cd = ?
    """
    
    guard let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd]) else {
      return nil
    }
    
    rs.next()
    let departId = rs.int(forColumn: "depart_cd")
    let departTitle = rs.string(forColumn: "depart_title")
    let departAddr = rs.string(forColumn: "depart_addr")
    
    return (Int(departId), departTitle!, departAddr!)
  }
  
  func create(title: String, addr: String) -> Bool {
    guard !title.isEmpty && !addr.isEmpty else {
      return false
    }
    
    do {
      let sql = """
        INSERT INTO department (depart_title, depart_addr)
        VALUES ( ? , ? )
      """
      
      try self.fmdb.executeUpdate(sql, values: [title, addr])
      return true
    } catch let error {
      print ("Insert Error : \(error.localizedDescription)")
      return false
    }
  }
  
  func remove(departCd: Int) -> Bool {
    do {
      let sql = "DELETE FROM department WHERE depart_cd = ?"
      try self.fmdb.executeUpdate(sql, values: [departCd])
      return true
    } catch let error {
      print("DELETE Error : \(error.localizedDescription)")
      return false
    }
  }
}
