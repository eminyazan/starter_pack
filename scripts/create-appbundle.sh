flutter clean
flutter build appbundle --release --no-tree-shake-icons
cd ..
# shellcheck disable=SC2164
cd "$(pwd)/build/app/outputs/bundle/release/"
mv app-release.aab Tripy.aab
open .
