//
//  PresenterProtocol.swift
//  VoiceCommands
//
//  Created by ABSTRACT on 04/10/23.
//

import Foundation
import UIKit
protocol PresenterProtocol{
    var title: String { get }
    var description: String { get }
    var cellId: String { get }
    var cell: String { get }
    var list: [String:Any] { get }
    var listDelegate: ListProtocol? { get set}
    
    func loadCellForIndexPath(cell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func loadButton(target: Any?, action: Selector?) -> UIBarButtonItem?
    func actionButton(navigationController: UINavigationController?, currentController: ListProtocol?)
    func didSelectRow(index: IndexPath, controller: UIViewController)
    func update()
}
