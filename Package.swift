import PackageDescription

let package = Package(
  name: "Azkaban",
  exclude: [ "Sources/azkaban" ],
  dependencies: [
    .Package(url: "https://github.com/neonichu/Chores.git", majorVersion: 0),
    .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 4),
    .Package(url: "https://github.com/kylef/PathKit.git", majorVersion: 0, minor: 6),
  ]
)
