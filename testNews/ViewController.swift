//
//  ViewController.swift
//  testNews
//
//  Created by Malygin Georgii on 28.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    private var shadowImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        controller.getItem()
        crateDataSource()
        updateCollectionView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
    }
    
    var controller: ControllerInterface!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<JSONFile,DataItem>?
    
    private lazy var navBarTitle: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.text = "Маршруты"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var barItem = UIBarButtonItem(
        image: UIImage(named: "iconSettings"),
        style: .done, target: self, action: nil)

    private func setupView() {
        
        barItem.tintColor = UIColor(red: 0.07, green: 0.20, blue: 0.25, alpha: 1)
        navigationItem.rightBarButtonItem = barItem
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navBarTitle)
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func crateDataSource() {
        dataSource = UICollectionViewDiffableDataSource<JSONFile,DataItem>(collectionView: collectionView, cellProvider: {(collection, indexPath, config) -> UICollectionViewCell in
            guard let cell = collection.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.cornerRadius = 8
            cell.layer.backgroundColor = UIColor.white.cgColor
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 0.2
            cell.layer.masksToBounds = false
            cell.configureView(photoURL: config.images.first! ?? "fa" , nameLocation: config.title ?? "", sityName: config.city?.name ?? "", tagsName: config.type ?? "", rating: config.rating ?? 1, time: config.duration ?? "")
            return cell
        })
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createSection()
            }
        
        return layout
    }

    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(330))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }

        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<JSONFile,DataItem>()
            
            snapshot.appendSections(self.controller.itemsView!)
            for section in self.controller.itemsView! {
                snapshot.appendItems(section.data, toSection: section)
            }
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка загрузки данных", message: "Что-то пошло не так", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Обновить", style: .default, handler: { [weak self] action in
            self?.controller.getItem()
        })
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard var indexRefresh = self.controller.itemsView?.first?.data.count else {
            return
        }
        indexRefresh -= 1
        if indexPath.item == indexRefresh  {
            controller.getItem()
        }
    }
}
