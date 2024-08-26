//
//  HomeViewModel.swift
//  voiceMemo
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var selectedTab: Tab
  @Published var todosCount: Int
  @Published var memosCount: Int
  @Published var voiceRecordersCount: Int
  
  init(
    selectedTab: Tab = .voiceRecorder,
    todosCount: Int = 0,
    memoCount: Int = 0,
    voiceRecorderCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memoCount
    self.voiceRecordersCount = voiceRecorderCount
  }
}

extension HomeViewModel {
  func setTodosCount(_ count: Int) {
    todosCount = count
  }
  
  func setMemoCount(_ count: Int) {
    memosCount = count
  }
  
  func setVoiceRecordersCount(_ count: Int) {
    voiceRecordersCount = count
  }
  
  func changeSelectedTab(_ tab: Tab) {
    selectedTab = tab
  }
}
