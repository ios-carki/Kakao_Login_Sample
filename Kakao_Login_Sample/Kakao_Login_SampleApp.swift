//
//  Kakao_Login_SampleApp.swift
//  Kakao_Login_Sample
//
//  Created by Carki on 1/1/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct Kakao_Login_SampleApp: App {
    
    let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as! String
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
