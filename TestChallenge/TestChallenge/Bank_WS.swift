//
//  Bank_WS.swift
//  Challenge
//
//  Created by RicrdoRS on 4/29/20.
//  Copyright © 2020 Desarrollador1. All rights reserved.
//

import CoreData
import UIKit

public class Bank_WS {
    static let share = Bank_WS()
    public typealias blkResponde = (_ bankObjects : [BankObject], _ error : Error?) -> Void
    
    
    
    public func getListOfBanks(completionHandler  handler: @escaping blkResponde){
        var listBanks   = [BankObject]()
        let url = URL(string: "https://api.jsonbin.io/b/5ea2fa3e98b3d5375233ca89")!
        DispatchQueue.global(qos: .userInitiated).async{
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        listBanks =  try! JSONDecoder().decode([BankObject].self, from: data)
                    }
                }
                DispatchQueue.main.async {
                    handler(listBanks, error)
                }
            }.resume()
        }
    }
    
    func save(bankObjects : [BankObject]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        DispatchQueue.global(qos: .background).async {
            for bankObject in bankObjects{
                let entity = NSEntityDescription.entity(forEntityName: "Bank", in: managedContext)
                let task = NSManagedObject(entity: entity!, insertInto: managedContext)
                  
                task.setValue(bankObject.bankName, forKey: "bankName")
                task.setValue(bankObject.description, forKey: "bankDescription")
                task.setValue(bankObject.age, forKey: "age")
                task.setValue(bankObject.url, forKey: "url")
                  
                do {
                  try managedContext.save()
                } catch let error as NSError {
                  print(error.description)
                }
            }
        }
        
    }
    
    public func getListBank() -> [BankObject]{
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request        :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Bank")
        var listBanks      = [BankObject]()
        
        do {
            let fetchedResults = try managedContext.fetch(request)
            for item in fetchedResults {
                var bank = BankObject()
                bank.bankName       = (item as AnyObject).value(forKey: "bankName") as? String
                bank.description    = (item as AnyObject).value(forKey: "bankDescription") as? String
                bank.age            = (item as AnyObject).value(forKey: "age") as? Int
                bank.url            = (item as AnyObject).value(forKey: "url") as? String
                
                listBanks.append(bank)
            }
        } catch let error as NSError {
            print(error.description)
        }
        
        return listBanks
    }
    
}
