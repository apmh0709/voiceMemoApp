//
//  OnboardingViewModel.swift
//  voiceMemo
//

import Foundation

class OnboardingViewModel : ObservableObject {
  @Published var onboardingContents: [OnboardingContent]
  
  init(onboardingContents: [OnboardingContent] = [
    .init(imageFileName: "onboarding_1", title: "오늘의 할일", subTitle: "TODO list"),
    .init(imageFileName: "onboarding_2", title: "나만의 기록장", subTitle: "메모장으로 생각나는 기록"),
    .init(imageFileName: "onboarding_3", title: "하나라도 놓치지 않도록", subTitle: "음성메모 기능으로 기록까지"),
    .init(imageFileName: "onboarding_4", title: "정확한 시간의 경과", subTitle: "시간의 경과까지 체크")
  ]) {
    self.onboardingContents = onboardingContents
  }
}
