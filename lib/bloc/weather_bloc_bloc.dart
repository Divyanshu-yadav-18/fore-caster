import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit)async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY,language: Language.ENGLISH);
        Position position = await Geolocator.getCurrentLocation();
        Weather weather = await wf.currentWeatherByLocation(position.latitude, position.longitude,);
        emit(WeatherBlocSuccess(weather));

      } catch (e) {
        emit(WeatherBlocFailure());

      }
    });
  }
}
