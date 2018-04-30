//
//  VibrationViewController.swift
//  DaSample
//
//  Created by Junda on 30/4/18.
//  Copyright © 2018 Just2us. All rights reserved.
//

import UIKit
import Cartography
import AudioToolbox

class VibrationViewController: UIViewController {

    var contents: [Content] = [
        Content(title: "AudioServicesPlaySystemSoundWithCompletion"),
        Content(title: "Impact light"),
        Content(title: "Impact medium"),
        Content(title: "Impact heavy"),
        Content(title: "Selection changed"),
        Content(title: "Notification success"),
        Content(title: "Notification error"),
        Content(title: "Notification warning"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
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

extension VibrationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {

        case 0:
            AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)

        case 1:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case 2:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case 3:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        case 4:
            UISelectionFeedbackGenerator().selectionChanged()

        case 5:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case 6:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case 7:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)

        default: break
        }
    }

}

extension VibrationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let content = contents[indexPath.row]
        cell.textLabel?.text = content.title
        return cell
    }

}
