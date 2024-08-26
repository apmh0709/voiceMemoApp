//
//  ToodoListView.swift
//  voiceMemo
//

import SwiftUI

struct TodoListView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  @EnvironmentObject private var homeviewModel: HomeViewModel
  
  var body: some View {
    ZStack{
      // 투두 셀 리스트 구현
      VStack{
        if !todoListViewModel.todos.isEmpty {
          CustomNavigationBar(
            isDisplayLeftBtn: false,
            rightBtnAction: {
              todoListViewModel.navigationRightBtnTapped()
            },
            rightBtnType: todoListViewModel.navigationBarRightBtnMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }
        TitleView()
          .padding(.top,20)
        if todoListViewModel.todos.isEmpty {
          AnnouncementView()
        }
        else {
          TodoListContentView()
        }
      }
      WriteTodoBtnView()
        .padding(.trailing, 20)
        .padding(.bottom, 30)
    }
    .alert(
      "TODO list \(todoListViewModel.removeTodosCount)개 삭제하시겠습니까?",
      isPresented: $todoListViewModel.isDisplayRemoveTodoAlert
    ) {
      Button("삭제", role: .destructive) {
        todoListViewModel.removeBtnTapped()
      }
      Button("취소", role: .cancel) {
        
      }
    }
    .onChange(of: todoListViewModel.todos, perform: {todos in homeviewModel.setTodosCount(todos.count)})
  }
}
// 재사용 가능성이 없을 때는
//  var titleView: some View {
//    Text("Title")
//  }
//  func titleView() -> some View {
//    Text("Title")
//  }

// 재사용 가능성이 높을 때는 별도의 struct로 빼는 걸 선호
// 하지만 EnvironmentObject가 많을 경우에는 귀찮게 됨
private struct TitleView: View {
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  fileprivate var body: some View {
    HStack{
      if todoListViewModel.todos.isEmpty {
        Text("To do list\n를 추가해 보세요.")
      } else {
        Text("To do list \(todoListViewModel.todos.count)개")
      }
      Spacer()
    }
    .font(.system(size: 30,weight: .bold))
    .padding(.leading, 20)
  }
}

// Todolist 안내 뷰
private struct AnnouncementView : View {
  fileprivate var body: some View {
    VStack (spacing: 15){
      Spacer()
      
      Image("pencil")
        .renderingMode(.template)
      Text("\"매일 아침 5시 운동하자!\"")
      Text("\"내일 8시 수강 신청하자!\"")
      Text("\"1시 반 점심약속 리마인드 해보자!\"")
      
      Spacer()
    }
    .font(.system(size: 16))
    .foregroundColor(.customGray2)
  }
}

// todolist 컨턴츠 뷰
private struct TodoListContentView: View {
  @EnvironmentObject private var todoListViewModel: TodoListViewModel
  
  fileprivate var body: some View {
    VStack {
      HStack {
        Text("할일 목록")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)
        
        Spacer()
      }
      ScrollView(.vertical) {
        VStack(spacing: 0) {
          Rectangle()
            .fill(Color.customGray0)
            .frame(height: 1)
          
          ForEach(todoListViewModel.todos, id: \.self) { todo in TodoCellView(todo: todo)}
        }
      }
    }
  }
}
  
  private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(
//      todoListViewModel: TodoListViewModel,
      isRemoveSelected: Bool = false,
      todo: Todo) {
//      self.todoListViewModel = todoListViewModel
      _isRemoveSelected = State(initialValue: isRemoveSelected)
      self.todo = todo
    }
    fileprivate var body: some View {
      VStack(spacing: 20) {
        HStack{
          if !todoListViewModel.isEditTodoMode {
            Button(
              action: {
              todoListViewModel.selectedBoxTapped(todo)
            }, label: {
              todo.selected ? Image("selectedBox") : Image("unSelectedBox")
            })
          }
          VStack(alignment: .leading, spacing: 5) {
            Text(todo.title)
              .font(.system(size: 16))
              .foregroundStyle(Color(todo.selected ? .customIconGray : .customBlack))
              .strikethrough(todo.selected)
            Text(todo.convertedDayAndTime)
              .font(.system(size: 16))
              .foregroundStyle(Color(.customIconGray))
          }
          Spacer()
          
          if todoListViewModel.isEditTodoMode {
            Button(
              action: {
                isRemoveSelected.toggle()
                todoListViewModel.todoRemoveSelectedBoxTapped(todo)
              }, label: {
                isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
            })
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        Rectangle()
          .fill(Color.customGray0)
          .frame(height: 1)
      }
    }
  }

private struct WriteTodoBtnView : View {
  @EnvironmentObject private var pathModel: PathModel
  
  fileprivate var body: some View {
    VStack{
      Spacer()
      HStack{
        Spacer()
        Button(
          action: {
            pathModel.paths.append(.todoView)
          }, label: {
          Image("writeBtn")
        })
      }
    }
  }
}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
      .environmentObject(PathModel())
      .environmentObject(TodoListViewModel())
  }
}
