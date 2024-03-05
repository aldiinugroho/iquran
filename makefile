.PHONY: run build

run: # run the application
	@flutter clean
	@flutter pub get
	@flutter run lib/main.dart

build: ## build the application
	@flutter clean
	@flutter pub get
	@flutter build apk