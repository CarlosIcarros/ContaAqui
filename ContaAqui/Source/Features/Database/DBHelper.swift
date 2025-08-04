//
//  DBHelper.swift
//  ContaAqui
//
//  Created by Carlos Silva on 28/07/25.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?
    
    private init() {
        openDataBase()
        createTable()
    }
    
    private func openDataBase() {
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ContaAqui.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("error ao abrir o sql")
        }
    }
    
    private func createTable() {
        let createTableQuery = """
                   CREATE TABLE IF NOT EXISTS TransactionMonth (
                           id INTEGER PRIMARY KEY AUTOINCREMENT,
                           title TEXT,
                           category TEXT,
                           money TEXT,
                           date TEXT,
                           income INTEGER
                   );
               """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("tabela criada com sucesso")
            } else {
                print("erro na criacao da tabela")
            }
        } else {
            print("create table statement nao consegui executar")
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertTransaction(title: String, category: String, money: String, date: String, income: Bool) {
        let insertQuery = """
                            INSERT INTO TransactionMonth (title, category, money, date, income) VALUES (?, ?, ?, ?, ?);
                        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (category as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (money as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 5, (income ? 1 : 0))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("receita inserida com sucesso!!")
            } else {
                print("falha ao inserir a receita na tabela")
            }
        } else {
            print("insert statement falhou")
        }
        sqlite3_finalize(statement)
        
    }
    
    func fetchTrancastionMonth() -> [TransactionMonth] {
        let fetchQuery = "SELECT * FROM TransactionMonth"
        var statement: OpaquePointer?
        var transactionMonths: [TransactionMonth] = []
        
        if sqlite3_prepare(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
                    
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let title = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) } ?? "Unknown"
                let category = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) } ?? "Unknown"
                let money = sqlite3_column_text(statement, 3).flatMap { String(cString: $0) } ?? "Unknown"
                let date = sqlite3_column_text(statement, 4).flatMap { String(cString: $0) } ?? "Unknown"
                let incomeValue = sqlite3_column_int(statement, 5)
                let income = incomeValue == 1 ? "true" : "false"
                
                transactionMonths.append(TransactionMonth(id: id, title: title, category: category, money: money, date: date, income: income))
            }
        } else {
            print("SELECT statement falhou")
        }
        
        sqlite3_finalize(statement)
        
        return transactionMonths
    }
    
    func deleteTransactionMonth(byId id: Int) {
        let deleteQuery = "DELETE FROM TransactionMonth WHERE id = ?"
        
        var statemente: OpaquePointer?
        
        if sqlite3_prepare(db, deleteQuery, -1, &statemente, nil) == SQLITE_OK {
            sqlite3_bind_int(statemente, 1, Int32(id))
            
            if sqlite3_step(statemente) == SQLITE_DONE {
                print("Deletado com sucesso!")
            } else {
                print("erro ao deletar")
            }
        } else {
            print("deu erro no statemente")
        }
        
        sqlite3_finalize(statemente)
    }
}
