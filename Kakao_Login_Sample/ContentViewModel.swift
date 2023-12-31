//
//  ContentViewModel.swift
//  Kakao_Login_Sample
//
//  Created by Carki on 1/1/24.
//

import Foundation

import KakaoSDKUser
import KakaoSDKAuth

final class ContentViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await logout() {
                isLoggedIn = false
            }
        }
    }
    
    @MainActor
    func kakaoLogin() {
        Task {
            //카카오톡 설치 여부 확인 - 설치 돼 있을때
            if (UserApi.isKakaoTalkLoginAvailable()) {
                isLoggedIn = await handleLoginWithKakaoTalkApp()
            } else {
                //카카오톡 설치 여부 확인 - 설치 안돼 있을때
                isLoggedIn = await handleLoginWithKakaoAccount()
            }
        }
    }
    
    func handleLoginWithKakaoTalkApp() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    let idToken = oauthToken?.idToken ?? ""
                    let accessToken = oauthToken?.accessToken ?? ""
                    
                    print("ID Token: ", idToken)
                    print("Access Token: ", accessToken)
                    self.kakaoGetUserInfo()
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func handleLoginWithKakaoAccount() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func logout() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func kakaoGetUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                guard let user = user else { return }
                
                let userName = user.kakaoAccount?.name
                let userEmail = user.kakaoAccount?.email
                let userGender = user.kakaoAccount?.gender
                let userProfile = user.kakaoAccount?.profile?.profileImageUrl
                let userBirthYear = user.kakaoAccount?.birthyear
                
                let contentText =
                "user name : \(userName)\n userEmail : \(userEmail)\n userGender : \(userGender), userBirthYear : \(userBirthYear)\n userProfile : \(userProfile)"
                
                print("user - \(user)")
                print("Content Text: ", contentText)
                
                if userEmail == nil {
                    
                    return
                }
            }
        }
    }
}
