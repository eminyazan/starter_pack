flutter clean
flutter build apk --release --no-tree-shake-icons
cd ..
# shellcheck disable=SC2164
cd "$(pwd)/build/app/outputs/flutter-apk/"
mv app-release.apk TripySaha.apk
open .