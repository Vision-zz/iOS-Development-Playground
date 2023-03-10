//
//  CalendarViewVC.swift
//  Catalyst
//
//  Created by Sathya on 21/02/23.
//

import UIKit

class CalendarViewVC: UIViewController {

    lazy var calendarView: UICalendarView = {
        let calendarView = UICalendarView(frame: .zero)
        calendarView.calendar = Calendar(identifier: .iso8601)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.fontDesign = .rounded
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        title = "Calendar View"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(calendarView)
        addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
