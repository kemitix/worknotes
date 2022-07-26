#!/usr/bin/env bash

set -e

flutter pub get
flutter format --output=none --set-exit-if-changed .
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test --reporter expanded
spr land
