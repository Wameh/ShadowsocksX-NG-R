//
//  LoginWindowController.swift
//  ShadowsocksX-NG
//
//  Created by Youma W Guedalia Floriane on 2/2/20.
//  Copyright © 2020 qiuyuzhou. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController {
    
   static var instance:LoginWindowController?=nil
    
    @IBOutlet weak var emailView: NSTextFieldCell!
    @IBOutlet weak var pwdView: NSSecureTextFieldCell!
    @IBOutlet weak var loginButton: NSButton!
    
    @IBOutlet weak var msgView: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        msgView.stringValue = ""
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
    }
   override func keyUp(with event: NSEvent)

    {
        //print(event.keyCode)
        if event.keyCode == 36
        {
            doLogin()
        }
        super.keyUp(with: event)
        
    }
    @IBAction func didLogin(_ sender: AnyObject) {
        
        doLogin()
        
        
    }

    func doLogin(){
        msgView.stringValue = ""
        BASEAPI.Login(email: emailView.stringValue, pwd: pwdView.stringValue)
        
    }
    func finishedLogin(isLogin : Bool, msg:String) {
        
        print(msg);
        if(!isLogin){
          shakeWindows()
            msgView.stringValue = msg
        }else{
            let notice = NSUserNotification()
            notice.title = "Agakoti"
            notice.subtitle = "Brovo, Logged in successfully"
            
            NSUserNotificationCenter.default.deliver(notice)
            window?.performClose(self)
        }
    }
    
    
        
    func shakeWindows(){
        let numberOfShakes:Int = 8
        let durationOfShake:Float = 0.5
        let vigourOfShake:Float = 0.05
        
        let frame:CGRect = (window?.frame)!
        let shakeAnimation = CAKeyframeAnimation()
        
        let shakePath = CGMutablePath()
        
        shakePath.move(to: CGPoint(x:NSMinX(frame), y:NSMinY(frame)))
        
        for _ in 1...numberOfShakes{
            shakePath.addLine(to: CGPoint(x: NSMinX(frame) - frame.size.width * CGFloat(vigourOfShake), y: NSMinY(frame)))
            shakePath.addLine(to: CGPoint(x: NSMinX(frame) + frame.size.width * CGFloat(vigourOfShake), y: NSMinY(frame)))
        }
        
        shakePath.closeSubpath()
        shakeAnimation.path = shakePath
        shakeAnimation.duration = CFTimeInterval(durationOfShake)
        window?.animations = ["frameOrigin":shakeAnimation]
        window?.animator().setFrameOrigin(window!.frame.origin)
    }
    
}
