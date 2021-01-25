import UIKit

class TripViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    private var trips = [Trip(tripId: "Paris001", city: "Paris",
                              country: "France", featuredImage: UIImage(named: "paris"),
                              price: 2000, totalDays: 5, isLiked: false),
                         Trip(tripId: "Rome001", city: "Rome", country: "Italy",
                              featuredImage: UIImage (named: "rome"),
                              price: 800, totalDays: 3, isLiked: false),
                         Trip(tripId: "Istanbul001", city: "Istanbul", country: "Turkey",
                              featuredImage : UIImage(named: "istanbul"),
                              price: 2200, totalDays: 10, isLiked: false),
                         Trip(tripId: "London001", city: "London", country: "United Kingdom",
                              featuredImage: UIImage(named: "london"),
                              price: 3000, totalDays: 4, isLiked: false),
                         Trip(tripId: "Sydney001", city: "Sydney", country: "Australia",
                              featuredImage: UIImage(named: "sydney"),
                              price: 2500, totalDays: 8, isLiked: false),
                         Trip(tripId: "Santorini001", city: "Santorini",
                              country: "Greece", featuredImage: UIImage(named: "santorini"),
                              price: 1800, totalDays: 7, isLiked: false),
                         Trip(tripId: "NewYork001", city: "New York", country: "United States",
                              featuredImage: UIImage(named: "newyork"),
                              price: 900, totalDays: 3, isLiked: false),
                         Trip(tripId: "Kyoto001", city: "Kyoto", country: "Japan",
                              featuredImage: UIImage(named: "kyoto"),
                              price: 1000, totalDays: 5, isLiked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        collectionView.backgroundColor = UIColor.clear
        
        if UIScreen.main.bounds.size.height == 568.0 {
            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.itemSize = CGSize(width: 250.0, height: 330.0)
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension TripViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? TripCollectionViewCell
        
        guard let safeCell = cell else {
            return UICollectionViewCell()
        }
        
        safeCell.delegate = self
        safeCell.cityLabel.text = trips[indexPath.row].city
        safeCell.countryLabel.text = trips[indexPath.row].country
        safeCell.imageView.image = trips[indexPath.row].featuredImage
        safeCell.priceLabel.text = "$\(String(trips[indexPath.row].price))"
        safeCell.totalDaysLabel.text = "\(trips[indexPath.row].totalDays) days"
        safeCell.isLiked = trips[indexPath.row].isLiked
     
        safeCell.layer.cornerRadius = 4.0
        
        return safeCell
    }
}

extension TripViewController: TripCollectionViewCellDelegate {
    
    func didLikeButtonPressed(cell: TripCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            trips[indexPath.row].isLiked = !trips[indexPath.row].isLiked
            cell.isLiked = trips[indexPath.row].isLiked
        }
    }
}
