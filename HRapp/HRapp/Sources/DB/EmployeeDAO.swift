//
//  EmployeeDAO.swift
//  HRapp
//
//  Created by truth on 15/02/2019.
//  Copyright © 2019 kimtruth. All rights reserved.
//

import Foundation

import FMDB

enum EmpStateType: Int {
  case ing = 0
  case stop
  case out
  
  func desc() -> String {
    switch self {
    case .ing:
      return "재직중"
    case .stop:
      return "휴직"
    case .out:
      return "퇴사"
    }
  }
}

struct EmployeeVO {
  /// 사원 코드
  var empCd = 0
  /// 사원명
  var empName = ""
  /// 입사일
  var joinDate = ""
  /// 재직 상태 (기본값: 재직중)
  var stateCd = EmpStateType.ing
  /// 소속 부서 코드
  var departCd = 0
  /// 소속 부서명
  var departTitle = ""
}

class EmployeeDAO {
  
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
  
  func find() -> [EmployeeVO] {
    var employeeList = [EmployeeVO]()
    
    do {
      let sql = """
        SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
        FROM employee
        JOIN department On department.depart_cd = employee.depart_cd
        ORDER BY employee.depart_cd ASC
      """
      
      let rs = try self.fmdb.executeQuery(sql, values: nil)
      
      while rs.next() {
        var record = EmployeeVO()
        
        record.empCd = Int(rs.int(forColumn: "emp_cd"))
        record.empName = rs.string(forColumn: "emp_name")!
        record.joinDate = rs.string(forColumn: "join_date")!
        record.departTitle = rs.string(forColumn: "depart_title")!
        
        let cd = Int(rs.int(forColumn: "state_cd"))
        record.stateCd = EmpStateType(rawValue: cd)!
        
        employeeList.append(record)
      }
    } catch let error {
      print("failed: \(error.localizedDescription)")
    }
    
    return employeeList
  }
  
  func get(empCd: Int) -> EmployeeVO? {
    let sql = """
      SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
      FROM employee
      JOIN department On department.depart_cd = employee.depart_cd
      WHERE emp_cd = ?
    """
    
    guard let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd]) else {
      return nil
    }
    
    rs.next()
    var record = EmployeeVO()
    record.empCd = Int(rs.int(forColumn: "emp_cd"))
    record.empName = rs.string(forColumn: "emp_name")!
    record.joinDate = rs.string(forColumn: "join_date")!
    record.departTitle = rs.string(forColumn: "depart_title")!
    
    let cd = Int(rs.int(forColumn: "state_cd"))
    record.stateCd = EmpStateType(rawValue: cd)!
    
    return record
  }
  
  func create(param: EmployeeVO) -> Bool {
    do {
      let sql = """
        INSERT INTO employee (emp_name, join_date, state_cd, depart_cd) VALUES ( ? , ? , ? , ? )
      """
      
      var params = [Any]()
      params.append(param.empName)
      params.append(param.joinDate)
      params.append(param.stateCd.rawValue)
      params.append(param.departCd)
      
      try self.fmdb.executeQuery(sql, values: params)
      
      return true
    } catch let error {
      print("failed: \(error.localizedDescription)")
      return false
    }
  }
  
  func remove(empCd: Int) -> Bool {
    do {
      let sql = "DELETE FROM employee WHERE emp_cd = ? "
      try self.fmdb.executeUpdate(sql, values: [empCd])
      return true
    } catch let error {
      print("Delete Error :\(error.localizedDescription)")
      return false
    }
  }
  
}
