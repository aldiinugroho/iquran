.PHONY: run build build_bundle

run: # run the application
	@flutter clean
	@flutter pub get
	@flutter run lib/main.dart

build: ## build the application
	@flutter clean
	@flutter pub get
	@flutter build apk

build_bundle: ## build the Android application bundle
	@flutter clean
	@flutter pub get
	@flutter build appbundle