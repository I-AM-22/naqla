# Common State 🔮

Common State is a Flutter package designed to simplify state management in Flutter applications, especially when working with the [flutter_bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc) package. It aims to automate state control, emitting the appropriate state (success, failure, loading, etc.) based on the application's data flow.

## Features

- **Automatic State Management**: Automatically handles state transitions, including success, failure, and loading states.
- **Pagination Support**: Built-in support for paginated data handling.
- **Customizable Error Handling**: Allows for custom error types to be defined and handled.
- **Integration with flutter_bloc**: Designed to work seamlessly with the flutter_bloc package, but can also be used with Cubit.



## Getting Started

Add the package to your pubsbc.yaml:
```yaml
  common_state:
    git:
      url: https://gitlab.com/humynewversion/common_state.git
      ref: 0.5.1
```

**Define your app overrides (OPTIONAL):**
Defining your own types from `CommonState` types will facilitate your usage as you have to define your error type only once.
Assuming your error class is named CustomErrorType here is an example.

```dart
typedef AppStates = States<>; // Map<String,CommonState<dynamic,>>

typedef FutureResult<T>= CommonStateFutureResult<T,>

typedef AppCommonState<T> = CommonState<T>;

typedef Success<T> = SuccessState<T>;
typedef Loading<T> = LoadingState<T>;
typedef Failure<T> = FailureState<T>;
typedef Empty<T> = EmptyState<T>;
typedef Initial<T> = InitialState<T>;
```

## Usage
Here is a simple implementation that will guide you to write your first CommonState controlled state.

### 1. Define Your State Class

Create a state class that extends `StateObject`. This class will manage your application's states.

```dart
class ExampleState extends StateObject<ExampleState> {
 static const String state1 = 'getData';
 static const String state2 = 'postData';
 static const String state3 = 'getPaginatedData';

 ExampleState([States? states])
      : super(
          [
            const Initial<String>(state1),
            const Initial<bool>(state2),
            PaginationState<PaginationModel<String>>(state3)
          ],
          (states) => ExampleState(states),
          states,
        );
}
```

### 2. Define Your Events

Define events that your Bloc or Cubit will handle. These events represent the different actions that can be performed in your application.

```dart
abstract class ExampleEvent {}

class Fetch extends ExampleEvent {
 const Fetch();
}

class Post extends ExampleEvent {
 const Post();
}

class FetchPaginated extends ExampleEvent {
 final int pageKey;
 const FetchPaginated(this.pageKey);
}
```

### 3. Define Your Bloc or Cubit

In your Bloc or Cubit, use the provided methods to handle API calls and paginated data fetching.

```dart
class MultiStateBloc extends Bloc<CommonStateEvent, MultiStateBlocState> {
 MultiStateBloc() : super(MultiStateBlocState()) {
    // No need to call on<Event>, just do it like so, the generics are - <Event, ReturnType>
    multiStateApiCall<Fetch, String>(ExampleState.state1, (event) => getSomeDataUseCase());

    multiStateApiCall<Post, bool>(ExampleState.state2, (event) => postSomeDataUseCase());

    multiStatePaginatedApiCall<FetchPaginated,PaginationModel<String>>(ExampleState.state3, (event) => someUseCase(), (event) => event.pageKey);
 }
}
```

### 4. Use Builders in Your UI

Utilize the provided builders to easily manage UI based on the state of your application.

- `ResultBuilder`: For Handling result <span style="background-color: #616115">Pass the stateName if you have multi common state object.</span>
- `CommonStatePaginatedBuilder`: For a Bloc/Cubit with multiple CommonState instances for paginated data.

## Additional Considerations

- **PaginationModel<T>**: Use `PaginationModel<T>` as your pagination model. If your pagination model is nested, inherit from `PaginatedModel<T>` and override the `getPaginatedDataMethod`.
  
- **Additional properties**: In case you want to store other variables in your state, other than the `states` that's provided by the `StateObject` make sure to override the `props` method to ensure that your updates will take place.
  ```dart
  @immutable
  class MultiStateBlocState extends StateObject<MultiStateBlocState> {
    final bool? someProperty;
    final ExampleProperty? exampleProperty; 

    MultiStateBlocState([
      States? states,
      this.someProperty,
      this.exampleProperty,
    ]) : super(
            [
              const Initial<String>('state1'),
              const Initial<int>('state2'),
              PaginationState<SomPaginatedData, String>('state3Pagination')
            ],
            (states) => MultiStateBlocState(states, someProperty, exampleProperty),
            states,
          );  

    MultiStateBlocState copyWith({bool? someProperty, ExampleProperty? exampleProperty}) => MultiStateBlocState(
          states,
          someProperty ?? this.someProperty,
          exampleProperty ?? this.exampleProperty,
        );  

    // Add your additional properties to the props lis like so...
    @override
    List<Object?> get props => [states, someProperty, exampleProperty];
  }
    ```

## Example

For a complete usage example, refer to the [Example App](https://gitlab.com/humynewversion/common_state/-/tree/main/example?ref_type=heads).

## Conclusion

Common State is designed to make state management in Flutter applications easier and more efficient. Whether you're working with simple states or complex paginated data, Common State provides the tools you need to manage it all.

*Happy Coding ⭐*