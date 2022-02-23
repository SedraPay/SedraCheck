<p align="center">
  <img src="https://github.com/SedraPay/SedraCheck/blob/main/SedraCheck.png" alt="Icon"/>
</p>
<H1 align="center">SedraCheck</H1>

The new eKYC in simple way.

`SedraCheck` is between your hands to help you onboard your customer easily with almost no effort.

## Screenshot
[![SedraCheck](https://github.com/SedraPay/SedraCheck/blob/main/screenshot.png)](https://youtu.be/8oehz24fXI4)


## Video

<a href="https://youtu.be/8oehz24fXI4" target="_blank"><img src="https://i.ytimg.com/vi/8oehz24fXI4/maxresdefault.jpg"
alt="SedraCheck Demo Video" width="480" height="360" border="10" /></a>



## Requirements
[![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg?style=fla)]()



Installation
==========================

SedraCheck is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SedraCheck'

//also add this
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
```

Then install it in terminal using below lines:
pod install
-- OR --
pod install --repo-update


## Add below line into your AppDelegate.swift


```swift
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController),
         (rootViewController.responds(to: Selector(("canRotate")))) else{
            // Only allow portrait (standard behaviour)
            return .portrait;
        }
        // Unlock landscape view orientations for this view controller
        return .landscapeRight;
    }

    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        guard rootViewController != nil else { return nil }

        guard !(rootViewController.isKind(of: (UITabBarController).self)) else{
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        }
        guard !(rootViewController.isKind(of:(UINavigationController).self)) else{
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        }
        guard !(rootViewController.presentedViewController != nil) else{
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
```

### Lets Start coding

## First step is required to have so you will create session and can use below steps

###### Create Journey ######

```swift
import SedraCheck

//Mandatory step to add

override func viewDidLoad(){
    super.viewDidLoad()
    
    //assign the delegate to your viewController
    SedraCheck.shared.delegate = self
    
/// Below function is required to continue using the framework, you have to enter all parameters to let the framework works fine
/// - Parameters:
///   - serverKey: this key will be from the portal
///   - serverURLString: the base url that sent to you by sales team
///   - needLog: this will show the errors in the debug
///   - journeyType: this is enum that contains 3 types (.unknown, .new, .update) to show the user is new or updating the profile.
///      If you are not intersted to check the type don't add it or set the type as .unknown

    SedraCheck.shared.setSettings(serverKey: "<YOUR_SERVER_KEY>", serverURLString: "<YOUR_GIVEN_SERVER>", true, .update) 
}

extension <YOUR_VIEW_CONTROLLER>: SedraCheckJourneyDelegate{
    func didFinishCreatingJourneyWithError(error: String) {
        //do your own code as:
        //dismiss dialogs
        //recall the function
    }
    
    func didFinishCreatingJourneyWithSuccess(journeyId: String) {
        //do your own code as:
        //dismiss dialog 
        //save the journey if needed as a reference to your server to check user from our protal
    }
}
```
###### END OF CREATE JOURNEY ######


###### Sedra Check ######

If you need to let the user capture the document (id, passport), use below code:

```swift

//put this code when you need to capture the document.
@objc func myButtonAction(_ sender: UIButton){
    SedraCheck.documentsCheck.delegate = self

    /// Below function is for ocr the document and get the information of the user.
    /// - Parameters:
    ///   - documentType: this is an enum (.id, .passport)

    SedraCheck.documentsCheck.captureDocuments(documentType: .id)
}

extension <YOUR_VIEW_CONTROLLER>: SedraCheckDocumentsDelegate{
    func userDidCloseCamera(){
    
    }
    func userFinishCapturingDocument(documents: [SedraCheckDocument]){
    
    }
    func userFinishCapturingDocumentsWithResponse(documents: [SedraCheckDocument], response: SedraCheckDocumentVerificationResponse){
    
    }
    func userFinishCapturingDocumentsWithError(documents: [SedraCheckDocument]){
    
    }
}
```
###### END OF SEDRA CHECK ######


###### Sedra Liveness Check ######

If you need to check user liveness and take a selfie, use below code:

```swift

//put this code when you need to check liveness.
@objc func myButtonAction(_ sender: UIButton){
    SedraCheck.livenessCheck.delegate = self


    /// Below function is for checking the liveness of the user and take a photo for the user.
    /// - Parameters:
    ///   - viewController: current viewController

    SedraCheck.livenessCheck.checkLiveness(viewController: self)
}

extension <YOUR_VIEW_CONTROLLER>: SedraCheckLivenessCheckDelegate{
    func didPressCancel(){
    
    }
    func didGetImageSuccessfully(data: UIImage){
    
    }
    func didGetImageMatchingResponseSuccessfully(response: ImageMatchingResponse){
    
    }
    func didGetError(errorMessage: String){
    
    }
}
```
###### END OF SEDRA LIVENESS CHECK ######


###### Sedra Comply ######



```swift

//put this code when you need to check your user in the world check.
@objc func myButtonAction(_ sender: UIButton){
    SedraCheck.comply.delegate = self

    /// Below function is for screening and checking the customer.
    /// - Parameters:
    ///   - firstName: enter the first name of the user <Required>
    ///   - secondName: enter the second name of the user <Optional>, leave empty string if not needed
    ///   - thirdName: enter the third name of the user <Optional>, leave empty string if not needed
    ///   - lastName: enter the last name of the user <Required>

    SedraCheck.comply.screenCustomer(firstName: "<FIRST_NAME_HERE>",
                                    secondName: "<SECOND_NAME_HERE>",
                                    thirdName: "<THIRD_NAME_HERE>",
                                    lastName: "<LAST_NAME_HERE>")
}

extension <YOUR_VIEW_CONTROLLER>: SedraComplyDelegate{
    func screeningFinishedWithSuccess(response: SedraCheckScreeningResponse){
        //do your code here
    }
    
    func screeningFinishedWithError(message: String){
        //do your code here
    }
}
```
###### END OF SEDRA COMPLY ######


Localization
==========================
Check localizable.string file in the project and translate it in the way you love.


Contact Us
==========================

If you have any questions or you want to contact us, visit our website.

https://sedracheck.sedrapay.com/


--- OR ---

Contact us via email mob@sedrapay.com

