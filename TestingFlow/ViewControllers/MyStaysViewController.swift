//
//  MyStaysViewController.swift
//  TestingFlow
//
//  Created by Alexander Cyon on 2018-02-05.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import UIKit
import RxSwift
import RxFlow
import RxDataSources
import ViewComposer
import TinyConstraints

final class MyStaysViewController: UIViewController {
    
    private lazy var tableView: UITableView = { return UITableView() }()
    private lazy var refreshControl = UIRefreshControl()
    
    let viewModel: MyStaysViewModel
    
    init(viewModel: MyStaysViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupBindings()
    }
}


private extension MyStaysViewController {
    
    func setupBindings() {

//        viewModel.bookings.observeOn(MainScheduler.instance)
//            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
//            .bind(to: tableView.rx.items(cellIdentifier: BookingCell.cellIdentifier, cellType: BookingCell.self))
//        //            { [weak self] (_, repo, cell) in
//        //                self?.setupRepositoryCell(cell, repository: repo)
//        //            }
//        //            .disposed(by: disposeBag)
//
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
    }
    
    func setupViews() {
        title = "My stays"
        tableView.backgroundColor = .purple
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.sendActions(for: .valueChanged)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}

protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}
final class BookingCell: UITableViewCell, CellIdentifiable {
    static var cellIdentifier: String = "BookingCell"
}
extension Reactive where Base: UITableView {
    
    func iXtems<S, C, O>(cellType: C.Type = C.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, C) -> Void)
        -> Disposable
        where O.E == S, O: ObservableType, S: Sequence, C: UITableViewCell & CellIdentifiable {
            return items(cellIdentifier: C.cellIdentifier, cellType: C.self)
    }
}
