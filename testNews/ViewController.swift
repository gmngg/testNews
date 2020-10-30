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
        collectionView.dataSource = self
        collectionView.delegate = self
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
        collectionView?.reloadData()
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controller.itemsView?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let items = self.controller.itemsView?[indexPath.item].data
        
        cell.layer.cornerRadius = 8
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        DispatchQueue.main.async {
            cell.configureView(photoURL: (items?.images.first ?? "") ?? "", nameLocation: items?.title ?? "", sityName: items?.city?.name ?? "", tagsName: items?.agency?.type ?? "", rating: items?.rating ?? 0, time: items?.duration ?? "")
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard var indexRefresh = self.controller.itemsView?.count else {
            return
        }
        indexRefresh -= 2
        if indexPath.item == indexRefresh  {
            controller.getItem()
        }
    }
}
