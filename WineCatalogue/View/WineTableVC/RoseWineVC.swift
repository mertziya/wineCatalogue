//
//  RoseWineVC.swift
//  WineCatalogue
//
//  Created by Mert Ziya on 4.12.2024.
//

import UIKit
import RxSwift
import RxCocoa

class RoseWineVC: UIViewController {

    var observedWines = [Wine]() // wines observed from the view model
    var wineVM = WineViewModel()
    let disposeBag = DisposeBag()
    
    let webService = WebService()
    var selectedWineFromTable : Wine?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
        wineVM.loadWines(type: .rose) // loads data and initializes the first ten object to observedWines.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "WineCell", bundle: nil), forCellReuseIdentifier: "WineCell")
    }

}


extension RoseWineVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observedWines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath) as? WineCell else{
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
                self.indicator.startAnimating()
            }
            
            self.wineVM.getWines(amount: 10)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedWineFromTable = self.observedWines[indexPath.row]
        performSegue(withIdentifier: "RoseWineVCtoWineDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoseWineVCtoWineDetailsVC"{
            if let destinationVC = segue.destination as? WineDetailsVC{
                destinationVC.selectedWine = self.selectedWineFromTable
            }
        }
    }
}

extension RoseWineVC{
    func setBindings(){
        wineVM
            .publishedWines
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { eventWineArray in
                if let wines = eventWineArray.element {
                    self.observedWines = wines
                    self.tableView.reloadData()
                }
            }.disposed(by: disposeBag)
    }
}

