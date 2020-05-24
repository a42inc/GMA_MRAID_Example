import GoogleMobileAds
import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    var bannerView: DFPBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addScrollView()
        
        bannerView = DFPBannerView(adSize: kGADAdSizeBanner)
        bannerView.backgroundColor = .gray

        bannerView.adUnitID = "REPLACE_WITH_YOUR_AD_UNIT_ID"
        bannerView.adSize = kGADAdSizeLargeBanner

        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.appEventDelegate = self
        bannerView.load(DFPRequest())
        addBannerView(self.bannerView)
    }
    
    func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true;
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height*2)
    }
    
    func addBannerView(_ bannerView: DFPBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bannerView)
        scrollView.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: scrollView,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: scrollView,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
        }

}

extension ViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}

extension ViewController: GADAppEventDelegate {
    func adView(_ banner: GADBannerView,
                didReceiveAppEvent name: String,
                withInfo info: String?) {
        guard let info = info else {return}
        print("\(name) - \(info)")
    }
        
}
