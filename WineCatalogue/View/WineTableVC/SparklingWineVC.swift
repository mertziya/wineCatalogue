//
//  SparklingWineVC.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 4.12.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SparklingWineVC: UIViewController {
    var observedWines = [Wine]() // wines observed from the view model
    var wineVM = WineViewModel()
    let disposeBag = DisposeBag()
    
    let webService = WebService()
    
    var selectedWineFromTable : Wine?

    @IBOutlet weak var sparklingTableView: UITableView!
    @IBOutlet weak var sparklingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        wineVM.loadWines(type: .sparkling) // loads data and initializes the first ten object to observedWines.
        
        self.sparklingTableView.delegate = self
        self.sparklingTableView.dataSource = self
        self.sparklingTableView.register(UINib(nibName: "WineCell", bundle: nil), forCellReuseIdentifier: "WineCell")
    }
    
}

extension SparklingWineVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.observedWines.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.sparklingTableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath) as? WineCell else{
            print("couldn't dequeue the WineCell")
            return UITableViewCell()
        }
     
        cell.wineName.text = self.observedWines[indexPath.row].wine
        webService.loadImage(imageUrlString: self.observedWines[indexPath.row].image) { image in
            cell.wineImage.image = image
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
      
        if position > (contentHeight - frameHeight - 100){
            
            DispatchQueue.main.async {
                self.sparklingIndicator.startAnimating()
            }
            
            self.wineVM.getWines(amount: 10)
            
            DispatchQueue.main.async {
                self.sparklingTableView.reloadData()
                self.sparklingIndicator.stopAnimating()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedWineFromTable = self.observedWines[indexPath.row]
        performSegue(withIdentifier: "SparklingWineVCtoWineDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SparklingWineVCtoWineDetailsVC"{
            if let destinationVC = segue.destination as? WineDetailsVC{
                destinationVC.selectedWine = self.selectedWineFromTable
            }
        }
    }
}

extension SparklingWineVC{
    func setBindings(){
        wineVM
            .publishedWines
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { eventWineArray in
                if let wines = eventWineArray.element {
                    self.observedWines = wines
                    self.sparklingTableView.reloadData()
                }
            }.disposed(by: disposeBag)
    }
}
