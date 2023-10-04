//
//  CommandsActionListController.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 03/10/23.
//

import Foundation
import UIKit
protocol ListProtocol{
    func refresh()
}
class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListProtocol{
   
    var presenter: PresenterProtocol
    var table: UITableView?
    
    init(_presenter: PresenterProtocol) {
        self.presenter = _presenter
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellId, for: indexPath)
        return presenter.loadCellForIndexPath(cell: cell, cellForRowAt: indexPath)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = presenter.loadButton(target: self, action: #selector(actionButton))
        self.view.backgroundColor = UIColor.white
        var offsetY = self.navigationController  != nil ? 100.0 : 20
        let margin = 20.0
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: margin, y: offsetY), size: CGSize(width: self.view.bounds.size.width - (margin*2), height: 35)))
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.text = self.presenter.title
        self.view.addSubview(titleLabel)
        offsetY += titleLabel.bounds.size.height
        let subtitleLabel = UILabel(frame: CGRect(origin: CGPoint(x: margin, y: offsetY), size: CGSize(width: self.view.bounds.size.width - (margin*2), height: 50)))
        subtitleLabel.font = .italicSystemFont(ofSize: 14)
        subtitleLabel.text = self.presenter.description
        subtitleLabel.numberOfLines = 0
        self.view.addSubview(subtitleLabel)
        offsetY += subtitleLabel.bounds.size.height
        offsetY += 10
        
        
        table = UITableView(frame:CGRect(x: margin, y: offsetY, width:  self.view.bounds.size.width - (margin*2), height: self.view.bounds.size.height - offsetY), style: .plain)
        if let _table = table{
            _table.register(UINib(nibName: presenter.cell, bundle: nil), forCellReuseIdentifier: presenter.cellId)
            _table.delegate = self
            _table.dataSource = self
            self.view.addSubview(_table)
        }
       
    }
    @objc func actionButton(){
        self.presenter.actionButton(navigationController: self.navigationController, currentController: self)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(index: indexPath,controller:  self)
    }
    func refresh() {
        self.presenter.update()
        self.table?.reloadData()
        
    }
    
}
