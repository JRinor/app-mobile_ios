//
//  FooterMenuView.swift
//  iosProject
//
//  Created by Lucas Plateau on 5/24/24.
//
import SwiftUI
import Foundation

struct FooterMenuView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ZStack {
                if selectedTab == 0 {
                    Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
                }
                LocalisationView()
            }
            .tabItem {
                CustomTabItem(label: "IP Finder", systemImage: "location.circle", isSelected: selectedTab == 0, selectedColor: .blue)
            }
            .tag(0)

            ZStack {
                if selectedTab == 1 {
                    Color.green.opacity(0.1).edgesIgnoringSafeArea(.all)
                }
                TranslateView()
            }
            .tabItem {
                CustomTabItem(label: "Traduction", systemImage: "repeat.circle.fill", isSelected: selectedTab == 1, selectedColor: .green)
            }
            .tag(1)

            ZStack {
                if selectedTab == 2 {
                    Color.purple.opacity(0.1).edgesIgnoringSafeArea(.all)
                }
                VeriphoneView()
            }
            .tabItem {
                CustomTabItem(label: "Veriphone", systemImage: "phone.circle.fill", isSelected: selectedTab == 2, selectedColor: .purple)
            }
            .tag(2)
        }
        .accentColor(selectedTabColor())
    }

    private func selectedTabColor() -> Color {
        switch selectedTab {
        case 0:
            return .blue
        case 1:
            return .green
        case 2:
            return .purple
        default:
            return .blue
        }
    }
}

struct CustomTabItem: View {
    let label: String
    let systemImage: String
    let isSelected: Bool
    let selectedColor: Color

    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .renderingMode(.original)
                .foregroundColor(isSelected ? selectedColor : .white)
            Text(label)
                .foregroundColor(isSelected ? selectedColor : .white)
        }
    }
}
