//
//  NewsTableViewController.swift
//  GoogleAdDemo
//
//  Created by Simon Ng on 29/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NewsTableViewController: UITableViewController {
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        return adBannerView
    }()
    
    var interstitialAd: GADInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "6e35aa63299e11fd21761c9216de0303383a4636" ]
        adBannerView.load(GADRequest())
        
        interstitialAd = createAndLoadinterstitial()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func createAndLoadinterstitial() -> GADInterstitial? {
        interstitialAd = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        guard let interstitialAd = interstitialAd else {
            return nil
        }
        
        let request = GADRequest()
        interstitialAd.load(request)
        interstitialAd.delegate = self
        
        return interstitialAd
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "val-throrens-france")
            cell.postTitle.text = "Val Thorens, France"
            cell.postAuthor.text = "BARA ART (bara-art.com)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "summer-beach-huts")
            cell.postTitle.text = "Summer Beach Huts, England"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else {
            cell.postImageView.image = UIImage(named: "taxis-nyc")
            cell.postTitle.text = "Taxis, NYC"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adBannerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section : Int) -> CGFloat {
        return adBannerView.frame.height
    }
    
}

// MARK: - GADBannerView Delegate methods

extension NewsTableViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}

extension NewsTableViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        ad.present(fromRootViewController: self)
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial")
    }
}
