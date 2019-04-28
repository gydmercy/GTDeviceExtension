//
//  GTDeviceExtension.swift
//  Guglielmo Faglioni
//
//  Created by Gorilla Technologies on 2/17/15.
//  Copyright (c) 2015 Guglielmo Faglioni. All rights reserved.
//

import UIKit

extension UIDevice {

    //Device Code : iPhone7,2, iPhone6,1, ...
    public var deviceCode: String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)
        return String.init(cString: hw_machine)
    }

    // Device Family : iPhone,iPad, ...
    public var deviceFamily: String {
        return UIDevice.current.model
    }

    //Device Model : iPhone 6, iPhone 6 plus, iPad Air, ...
    public var deviceModel: String {

        var model : String
        let deviceCode = UIDevice().deviceCode
        switch deviceCode {

        case "iPod1,1":                                 model = "iPod Touch 1G"
        case "iPod2,1":                                 model = "iPod Touch 2G"
        case "iPod3,1":                                 model = "iPod Touch 3G"
        case "iPod4,1":                                 model = "iPod Touch 4G"
        case "iPod5,1":                                 model = "iPod Touch 5G"
        case "iPod7,1":                                 model = "iPod Touch 6G"


        case "iPhone1,1":                               model = "iPhone 2G"
        case "iPhone1,2":                               model = "iPhone 3G"
        case "iPhone2,1":                               model = "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     model = "iPhone 4"
        case "iPhone4,1":                               model = "iPhone 4S"
        case "iPhone5,1", "iPhone5,2":                  model = "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  model = "iPhone 5C"
        case "iPhone6,1", "iPhone6,2":                  model = "iPhone 5S"
        case "iPhone7,2":                               model = "iPhone 6"
        case "iPhone7,1":                               model = "iPhone 6 Plus"
        case "iPhone8,1":                               model = "iPhone 6S"
        case "iPhone8,2":                               model = "iPhone 6S Plus"
        case "iPhone8,4":                               model = "iPhone SE"
        case "iPhone9,1", "iPhone9,3":                  model = "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  model = "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                model = "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                model = "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                model = "iPhone X"
        case "iPhone11,2":                              model = "iPhone Xs"
        case "iPhone11,4", "iPhone11,6":                model = "iPhone Xs Max"
        case "iPhone11,8":                              model = "iPhone XR"


        case "iPad1,1":                                 model = "iPad 1"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":model = "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           model = "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           model = "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           model = "iPad Air"
        case "iPad5,3", "iPad5,4":                      model = "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    model = "iPad 2017"
        case "iPad7,5", "iPad7,6":                      model = "iPad 2018"
        case "iPad11,3", "iPad1,4":                     model = "iPad Air 3"

        case "iPad2,5", "iPad2,6", "iPad2,7":           model = "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           model = "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           model = "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      model = "iPad Mini 4"
        case "iPad11,1", "iPad11,2":                    model = "iPad Mini 5"

        case "iPad6,3", "iPad6,4":                      model = "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":                      model = "iPad Pro 12.9"
        case "iPad7,1", "iPad7,2":                      model = "iPad Pro 12.9 v2"
        case "iPad7,3", "iPad7,4":                      model = "iPad Pro 10.5"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":model = "iPad Pro 11 v3"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":model = "iPad Pro 12.9 v3"


        case "i386", "x86_64":                          model = "Simulator"
        default:                                        model = deviceCode //If unkhnown
        }

        return model
    }

    //Device Jailbreaked or not
    public var deviceJailed: Bool {
        let path = "/Applications/Cydia.app"
        let fileExists = FileManager.default.fileExists(atPath: path)
        return fileExists
    }

    //Device iOS Version : 8.1, 8.1.3, ...
    public var deviceIOSVersion: String {
        return UIDevice.current.systemVersion
    }

    //Device Screen Width and Height
    public var deviceScreenWidth: CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width;
        return width
    }
    public var deviceScreenHeight: CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        let height = screenSize.height;
        return height
    }

    //Device Remaining free space
    public var deviceFreeSpace: Int64? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let systemAttributes = try! FileManager.default.attributesOfFileSystem(forPath: documentDirectoryPath.last!)
        if let freeSize = systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber {
            return freeSize.int64Value
        }
        return nil
    }

    //Device Orientation String
    public var deviceOrientationString: String {

        var orientation : String

        switch UIDevice.current.orientation{
        case .portrait:
            orientation="Portrait"
        case .portraitUpsideDown:
            orientation="Portrait Upside Down"
        case .landscapeLeft:
            orientation="Landscape Left"
        case .landscapeRight:
            orientation="Landscape Right"
        case .faceUp:
            orientation="Face Up"
        case .faceDown:
            orientation="Face Down"
        default:
            orientation="Unknown"
        }

        return orientation
    }


    // is Device Landscape, is Portrait
    public var isDevicePortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    public var isDeviceLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }

}

extension UIApplication {

    public var applicationVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    public var applicationBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public var versionBuild: String {
        let version = self.applicationVersion
        let build = self.applicationBuild
        
        let result = "v\(version)(\(build))";
        return result
    }
}

