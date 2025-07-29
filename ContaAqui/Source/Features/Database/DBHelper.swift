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
}
