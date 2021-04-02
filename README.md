## Convention
### Nameing 
- Will follow dart convention [here](https://dart.dev/guides/language/effective-dart/style) 
- **UpperCamelCase**: class, extension, enum
- **lowercase_with_underscores**: libraries, packages, directories, prefix, and source files
- **lowerCamelCase**: class members, top-level definitions, variables, parameters, and named parameters, **constant**
- _, __, ___: for unused callback parameters
- For buisiness logic file such as bloc: **must use underscore** prefix for variables and methods that unnecessary to be public.
### Bloc
- Package: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- Hold all logic of 1 screen/widget
- If there're too mane logic in 1 screen, should separate screen into smaller widgets then create blocs to handle those widgets.
- **AVOID** provide BLOC of screen from the top of widget tree, it will keep the instance of BLOC despite screen was disposed, only create BLOC instance inside of screen that means BLOC will be created when screen is opened. e.g:
    ```
    class StoreSizingGuideScreen extends StatefulWidget {
      static Widget newInstance() => BlocProvider(
          create: (context) {
            final dataRepo = context.repository<DataRepository>();
            return StoreSizingGuideBloc(dataRepo: dataRepo);
          },
          child: StoreSizingGuideScreen._());
    
      StoreSizingGuideScreen._();
    
      @override
      _StoreSizingGuideScreenState createState() => _StoreSizingGuideScreenState();
    }
    ```
    
- prefer use **Cubit** (more simple bloc) as below, 2 file: cubit and state:
    ```
    part 'sample_state.dart';
    
    class SampleCubit extends Cubit<SampleState> {
      SampleCubit() : super(SampleInitial());
    
      void getData() {
        emit(SampleGetDataLoading());
        emit(SampleGetDataSuccess());
      }
    }
    ```
    ```
    part of 'sample_cubit.dart';
    
    abstract class SampleState extends Equatable {
      final String id;
      const SampleState({this.id});
      @override
      List<Object> get props => [id];
    }
    class SampleInitial extends SampleState {}
    class SampleGetDataLoading extends SampleState {}
    class SampleGetDataSuccess extends SampleState {
      SampleGetDataSuccess({String id}): super(id: id);
    }
    ```
- rule: **Cubit** only receive actions and emit state, the Widget will act base on state of **Cubit**, **avoid** to hold any varibales or subject in the **Cubit**.

## Routing:
- use getx with named route
- define route like this:
    ```
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MyHomePage(),
        ),
        GetPage(
          name: '/profile/',
          page: () => Profiles(),
        ),
        GetPage(
          name: '/profile/user',
          page: () => UserProfile.newInstance(),
        ),
        GetPage(
          name: '/demo_storage',
          page: () => DemoStorageScreen(),
        ),
      ],
    )
    ```
- Then navigate like this:
    ```
    Get.toNamed("/profile/user?name=quan&age=18");
    ```
- Get the param:
    ```
    Get.parameters['name']
    ```
- The param need to be primitive value (int, double, string, bool), the screen need to use that param to call the api to get the info such as **userInfo** from **userId**.
- By above way, we can make sure that the app will work well when move to web, and all screens are not depend on each other, so it'll be easy to modulize and reuse the sceen.

## Repository:
- Man-in-middle
- Inform BLoCs for available functions to access
- Will call the **service client** to get the data from api, then return the response to bloc
## Service client:
- prefer using [Dio](https://pub.dev/packages/dio) and [Retrofit](https://pub.dev/packages/retrofit) for simple api definition like this
    ```
    @retrofit.GET('/stores/{storeID}/productRatings')
    Future<StoreRatingResponse> getStoreRatings({
        @retrofit.Path() String storeID,
    });
    ```
- Take the responsibility to create api call

## Models
- prefer using https://pub.dev/packages/json_serializable for auto generate code
## Constants:
- avoid hard code values inside the file
- should create class to hold that constant, ex:
    ```
    class HttpCode {
      static const int NOT_FOUND = 404;
      static const int BAD_REQUEST = 400;
    }
    ```
## Text:
- avoid create TextStyle localy inside widget, add it to AppText class so can be reuse and make the widget file shorter.

## CORE IDEA:
- 1 bloc 1 screen -> easy to reuse and modulize
- screens only receive param as primitive type (string, double, int, bool) -> easy to reuse and modulize
- create classes to hold constants, color, textstyle -> easy to change, easy to manage, shorter code base
- single responsibity bloc/widget/screen: easy to read, easy to change, easy to reuse