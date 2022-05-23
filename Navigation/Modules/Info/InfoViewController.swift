//
//  InfoViewController.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit
import SnapKit

protocol InfoViewControllerDelegate: AnyObject {
    func clickAlertAction()
}

final class InfoViewController: UIViewController {
    private var planetModel: PlanetModel?
    
    private lazy var infoView: InfoView = {
        infoView = InfoView(frame: .zero)
        return infoView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PeopleTableViewCell.self, forCellReuseIdentifier: "PeopleTableViewCell")
        tableView.backgroundColor = .blue
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        view.addSubviews([
            infoView,
            tableView
        ])
        setup()
        
        infoView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TodosApi.makeRequest { [weak self] result in
            switch result {
            case .success(let model):
                guard let model = model else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.infoView.configureTitle(model: model)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        PlanetApi.makeRequestPlanet { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async { [weak self] in
                    self?.planetModel = model
                    self?.infoView.configureOrbitalPeriod(model: model)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setup() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(infoView.snp.top).offset(-10)
            
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

extension InfoViewController: InfoViewControllerDelegate {
    func clickAlertAction() {
        let alert = UIAlertController(title: .title, message: .message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .yes, style: .default, handler: { alert -> Void in
            print(String.yes)
        }
        ))
        alert.addAction(UIAlertAction(title: .no, style: .cancel, handler: { alert -> Void in
            print(String.no)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let planetModel = planetModel else { return 0 }
        return planetModel.residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        guard let planetModel = planetModel else { return UITableViewCell() }
        let urlPeople = planetModel.residents[indexPath.row]
        PlanetApi.makeRequestPeople(urlPeople: urlPeople) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    cell.textLabel?.text = model.name
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    cell.textLabel?.text = error.localizedDescription
                }
            }
        }
        
        return cell
    }
}

private extension String {
    static let title = "Сообщение"
    static let message = "Хотите чтобы в консоль вывелся лог, нажмите на Да или Нет"
    static let yes = "Да"
    static let no = "Нет"
}
