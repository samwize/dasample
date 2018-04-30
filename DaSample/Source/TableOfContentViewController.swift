//
//  TableOfContentViewController.swift
//  DaSample
//
//  Created by Junda on 30/4/18.
//  Copyright © 2018 Just2us. All rights reserved.
//

import UIKit
import Cartography

class TableOfContentViewController: UIViewController {

    var contents: [Content] = [
        Content(title: "Vibration", description: "Via AudioToolbox, Haptic API")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Content"

        view.addSubview(tableView)
        constrain(view, tableView) { view, subview in
            subview.left == view.left
            subview.right == view.right
            subview.top == view.top
            subview.bottom == view.bottom
        }
    }

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let x = UITableView()
        x.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        x.delegate = self
        x.dataSource = self
        return x
    }()

}

extension TableOfContentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var vc: UIViewController?

        switch indexPath.row {
        case 0: vc = VibrationViewController()
        default: break
        }

        if let vc = vc {
            vc.title = contents[indexPath.row].title
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension TableOfContentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let content = contents[indexPath.row]
        cell.textLabel?.text = content.title
        cell.detailTextLabel?.text = content.description
        return cell
    }

}

struct Content {
    var title: String
    var description: String?

    init(title: String, description: String? = nil) {
        self.title = title
        self.description = nil
    }
}
