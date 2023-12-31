//
//  ContentView.swift
//  Kakao_Login_Sample
//
//  Created by Carki on 1/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    var body: some View {
        VStack {
            Button(action: {
                vm.kakaoLogin()
            }, label: {
                Text("카카오톡 로그인")
            })
            .buttonStyle(.borderedProminent)
            
            Button(action: {
                vm.kakaoLogout()
            }, label: {
                Text("카카오톡 로그아웃")
            })
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
