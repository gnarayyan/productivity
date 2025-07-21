# varosa_tech

A new Flutter project for evaluation exam in varosa technology

## Initial Thought
- Instead of making 5 different apps, I'll make a signgle app. So, all 5 apps can be navigated from 1st screen. This will help me to not waste time in creating project, installing dependencies, etc. Also it may help evaluator to examine a single codebase and single app
- First I'll make app compatible for android then run on ios emulator and make compatible for ios too
- If time avilable, I'll work on other things like themes,..,etc
- In code the folder structure I'll follow is:
```
lib/
    apps/
        offline_todo/
        dynamic_form/
        mini_ecommerce/
        method_channel/
        nested_bottom_nav/
    themes/
    core/
    common/

```
- Each folder will follow own architecture & pattern (to meet evaluation criteria) but if some logic is sharable like themes, components, it will be shared from common, core or themes folder. Please don't consider it as anti pattern(I will take this liberty for my easiness (i.e. reusability) )


## Development Environment
- Flutter: 3.32.7 
- Dart: 3.8.1
- OS: Ubuntu 24.04.2 LTS
- IDE: VS Code
- Later use MacOS, to make IoS compatible


# Apps
## 1. offline_todo
### Requirement
Evaluation:  state management, architecture, local storage SQLite, and async handling.
**Tasks:**
- Add/update/delete to-dos.​
- Persist to-dos using SQLite.​
- Handle UI state with Bloc.​
- Optional: Sync to-dos with firebase.

### My Thought Process
Since todo is a very basic app with just one faeture i.e. to CRUD Todos, so it felt me stupid to go for feature first, so I'll implement `Layer First` folder strcuture. 

### Third party libraries use will adjusted later
- cupertino_icons: ^1.0.8
  
**State Management**
- flutter_bloc: ^9.1.1
- equatable: ^2.0.7
  
**Local Storage**
- sqflite: ^2.4.2
- path: ^1.9.1
  
**Icons and UI**
- google_fonts: ^6.2.1
- lucide_icons: ^0.257.0
- get_it: ^8.0.3
- auto_route: ^10.1.0+1

**dev_dependencies:**
- flutter_lints: ^5.0.0
- auto_route_generator: ^10.2.3
- build_runner: ^2.5.4

### Folder Structure
```
lib/
│
├── apps/
│   └── offline_todo/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── local_datasource.dart
│       │   ├── models/
│       │   │   └── todo_model.dart
│       │   └── repositories/
│       │       └── todo_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── todo.dart
│       │   ├── repositories/
│       │   │   └── todo_repository.dart
│       │   └── usecases/
│       │       ├── add_todo.dart
│       │       ├── update_todo.dart
│       │       ├── delete_todo.dart
│       │       └── get_todos.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── todo_bloc.dart
│           │   ├── todo_event.dart
│           │   └── todo_state.dart
│           │
│           ├── pages/
│           │   ├── todo_list_page.dart
│           │   └── add_edit_todo_page.dart
│           │
│           └── widgets/
│               ├── todo_item.dart
│               └── todo_form.dart
│
├── core/
│   ├── landing_page/
│   │   ├── app_card.dart
│   │   ├── landing_page.dart
│   │   └── show_coming_soon_dialog.dart
│   │
│   └── router/
│       ├── app_router.dart
│       └── app_router.gr.dart
│
├── themes/
│   └── app_theme.dart
│
└── main.dart
```



## 4. method_channel
### Requirement
1.​ Use MethodChannel:
From native code, return a JSON map containing:​
​```json
{
"batteryLevel": 88,// int
"deviceModel": "Pixel 6",// string
"isCharging": true,// bool
"systemTime": "2025-06-09T12:30:00Z" // string (ISO format)
}
```
2.​ On the Flutter side:​
- Parse the JSON response and convert systemTime to a Dart DateTime​
- Display all values in a clean UI​
- Provide a button that, when clicked, fetches and displays the JSON data
3.​ Use PlatformView to show a native button. When this button is pressed then batter
percentage should be refreshed.


### My Thought Process
This app seems to be simplest of all. The only real challange is to implement `MethodChannel` for _Battery level_, _Device model_, _Charging status_, _System time_ and _Rendering a functional native button_ , so 

**Steps**
1. Implement MethodChannel call
2. Parse JSON
3. Build UI

**Folder Structure**
So I wanna use MVVM for this (not exactlt but alike)
```
method_channel/
    bloc/
        device_info_bloc.dart
        device_info_event.dart
        device_info_state.dart
    models/
        device_info.dart
    services/
        device_info_service.dart
    pages/
        method_channel_page.dart
    widgets/
        device_info_card.dart
        error_card.dart
        info_row.dart
        loading_card.dart
        native_button_view.dart
```

**Enhnacement Done**
- Better code structure
- Freezed for model generation
- Bloc for state management
- Check on IoS