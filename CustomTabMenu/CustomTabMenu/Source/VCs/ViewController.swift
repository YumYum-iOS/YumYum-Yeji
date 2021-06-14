//
//  ViewController.swift
//  CustomTabMenu
//
//  Created by 윤예지 on 2021/06/15.
//

import UIKit
import SnapKit
import Then


class ViewController: UIViewController {

    // MARK: - UI Properties
    var customTabbarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.backgroundColor = .white
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets.zero
        $0.collectionViewLayout = layout
    }
    
    var scrollView = UIScrollView(frame: .zero).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    var tabIndicator = UIView().then {
        $0.backgroundColor = .purple
    }
    
    // MARK: - Properties
    
    var tabSelectedIndex : Int = 0
    
    var tabList = ["첫번째", "두번째", "세번째", "네번째", "다섯번째"]
    

    let firstVC = FirstViewController()
    let secondVC = SecondViewController()
    let thirdVC = ThirdViewController()
    let fourthVC = FourthViewController()
    let fifthVC = FifthViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setDelegate()
        setUI()
        setScrollView()
    }

    func setDelegate() {
        customTabbarCollectionView.delegate = self
        customTabbarCollectionView.dataSource = self
        customTabbarCollectionView.register(tabMenuCollectionViewCell.self, forCellWithReuseIdentifier: "tabMenuCollectionViewCell")
    }
    
    func setUI() {
        view.addSubviews(scrollView, customTabbarCollectionView, tabIndicator)
        
        customTabbarCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customTabbarCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tabIndicator.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(customTabbarCollectionView.snp.bottom)
            $0.height.equalTo(3)
            $0.width.equalTo(UIScreen.main.bounds.width * (69/375))
        }
    }
    
    func setScrollView() {
        scrollView.delegate = self
        scrollView.contentSize.width = self.view.frame.width * 5
        
        self.addChild(firstVC)
        guard let kurlyRecommandView = firstVC.view else { return }
        kurlyRecommandView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(secondVC)
        guard let newProductView = secondVC.view else { return }
        newProductView.frame = CGRect(x: self.view.frame.width, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(thirdVC)
        guard let bestView = thirdVC.view else { return }
        bestView.frame = CGRect(x: self.view.frame.width * 2, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(fourthVC)
        guard let shoppingView = fourthVC.view else { return }
        shoppingView.frame = CGRect(x: self.view.frame.width * 3, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        self.addChild(fifthVC)
        guard let specialView = fifthVC.view else { return }
        specialView.frame = CGRect(x: self.view.frame.width * 4, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        scrollView.addSubviews(kurlyRecommandView, newProductView, bestView, shoppingView, specialView)
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabMenuCollectionViewCell", for: indexPath) as? tabMenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row != tabSelectedIndex {
            cell.setStatus(name: tabList[indexPath.row], isTouched: false)
        }
        else {
            cell.setStatus(name: tabList[indexPath.row], isTouched: true)
        }
    
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        tabSelectedIndex = indexPath.row

        switch indexPath.row {
        case 0:
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width, y: 0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 2, y: 0), animated: true)
        case 3:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 3, y: 0), animated: true)
        case 4:
            scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * 4, y: 0), animated: true)
        default:
            break
        }
        
        customTabbarCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellwidth = width * (69/375)
        
        return CGSize(width: cellwidth, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.width)
        
        switch page {
        case 0:
            tabSelectedIndex = 0
        case 1:
            tabSelectedIndex = 1
        case 2:
            tabSelectedIndex = 2
        case 3:
            tabSelectedIndex = 3
        case 4:
            tabSelectedIndex = 4
        default:
            break
        }
       
        customTabbarCollectionView.reloadData()
    }
    


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellwidth = UIScreen.main.bounds.width * (69/375)

        tabIndicator.snp.updateConstraints {
            $0.leading.equalToSuperview().offset( (scrollView.contentOffset.x / UIScreen.main.bounds.width) * cellwidth + 16)
        }
    }
}

