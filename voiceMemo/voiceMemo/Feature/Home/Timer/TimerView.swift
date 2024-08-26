//
//  TimerView.swift
//  voiceMemo
//

import SwiftUI

struct TimerView: View {
  @StateObject var timerViewModel = TimerViewModel()
  
  var body: some View {
    if timerViewModel.isDisplaySetTimeView {
      SetTimerView(timerViewModel: timerViewModel)
    } else {
      TimerOperationView(timerViewModel: timerViewModel)
    }
  }
}

private struct SetTimerView : View {
  @ObservedObject private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      TitleView()
      Spacer()
        .frame(height: 50)
      
      TimePickerView(timerViewModel: timerViewModel)
      
      Spacer()
        .frame(height: 30)
      
      TimerCreateBtnView(timerViewModel: timerViewModel)
      Spacer()
    }
  }
}

private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("타이머")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(Color.customBlack)
      
      Spacer()
    }
    .padding(.horizontal,30)
    .padding(.top,30)
  }
}

private struct TimePickerView: View {
  @ObservedObject private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(Color.customGray2)
        .frame(height: 1)
      
      HStack {
        Picker("Hour", selection: $timerViewModel.time.hours) {
          ForEach(0..<24) {
            hour in Text("\(hour)시")
          }
        }
        Picker("Minute", selection: $timerViewModel.time.minutes) {
          ForEach(0..<60) {
            minute in Text("\(minute)분")
          }
        }
        Picker("Second", selection: $timerViewModel.time.seconds) {
          ForEach(0..<60) {
            seconds in Text("\(seconds)초")
          }
        }
      }
      .labelsHidden()
      .pickerStyle(.wheel)
      
      Rectangle()
        .fill(Color.customGray2)
        .frame(height: 1)
    }
  }
}

private struct TimerCreateBtnView: View {
  @ObservedObject private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    Button(
      action: {
        timerViewModel.settingBtnTapped()
      },
      label: {
        Text("설정하기")
          .font(.system(size: 18, weight: .bold))
          .foregroundStyle(Color.customGreen)
    })
  }
}

private struct TimerOperationView: View {
  @ObservedObject private var timerViewModel: TimerViewModel
  
  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }
  
  fileprivate var body: some View {
    VStack {
      ZStack {
        VStack {
          Text("\(timerViewModel.timeRemaining.formattedTimeString)")
            .font(.system(size: 28))
            .foregroundStyle(Color.customBlack)
            .monospaced()
          
          HStack(alignment: .bottom) {
            Image(systemName: "bell.fill")
            
            Text("\(timerViewModel.time.convertedSeconds.formattedSettingTime)")
              .font(.system(size: 16))
              .foregroundStyle(Color.customBlack)
              .padding(.top, 10)
          }
        }
        Circle()
          .stroke(Color.customOrange, lineWidth: 6)
          .frame(width: 350)
      }
      
      Spacer()
        .frame(height: 10)
      
      HStack {
        Button(action: {timerViewModel.cancelBtnTapped()}, label: {Text("취소")
            .font(.system(size: 16))
            .foregroundStyle(Color.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 22)
            .background(
            Circle()
              .fill(Color.customGray2.opacity(0.3))
            )
        })
        Spacer()
        Button(
          action: {
            timerViewModel.pauseOrReStartBtnTapped()
          }, label: {
            Text(timerViewModel.isPaused ? "계속진행" : "일시정지")
              .font(.system(size: 14))
              .foregroundStyle(Color.customBlack)
              .padding(.vertical, 25)
              .padding(.horizontal, 7)
              .background(
                Circle()
                  .fill(Color(red: 1, green: 0.75, blue: 0.52).opacity(0.3))
              )
        })
      }
      .padding(.horizontal, 20)
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
  }
}
