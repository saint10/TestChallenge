//
//  ViewController.swift
//  Challenge
//
//  Created by RicrdoRS on 4/29/20.
//  Copyright © 2020 Desarrollador1. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource{

    @IBOutlet weak var tableBanks: UITableView!
    var listBanks : [BankObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Bancos"
        listBanks =  Bank_WS.share.getListBank()
        if listBanks?.isEmpty ?? true{
            callWebService()
        }else{
            tableBanks.reloadData()
        }
    }
    
    private func callWebService(){
        Bank_WS.share.getListOfBanks { [weak self](listBanks, error) in
            if error == nil {
                self?.listBanks = listBanks
                self?.tableBanks.reloadData()
                if let list = self?.listBanks{
                    Bank_WS.share.save(bankObjects: list)
                }
            }else{
                print("error")
            }
        }
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBanks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "idCellBank") as? BankCell {
            cell.lblName.text           = listBanks?[indexPath.row].bankName ?? ""
            cell.lblDescription.text    = listBanks?[indexPath.row].description ?? ""
            cell.lblAge.text            = "\(listBanks?[indexPath.row].age ?? 0)"
            cell.url                    = listBanks?[indexPath.row].url ?? ""
            cell.delegate               = self
            
            return cell
        }
        return BankCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

extension ViewController: BankCellDelegate{
    func openUrl(url: String) {
        if let urlTryOpen = URL(string: url) {
            if UIApplication.shared.canOpenURL(urlTryOpen) {
                UIApplication.shared.open(urlTryOpen)
            }
        }
    }
    
}
