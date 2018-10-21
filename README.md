# BetterErrors

Tired of getting this error:

```
The operation could not be completed
```

Just do this:

```swift
import BetterErrors

do {
  let content = try String(contentsOfFile: "doesnt-exist.txt")
  print(content)
} catch let error as NSError {
  print(error.betterDescription)
}
```

SPM usage:

```
.package(url: "https://github.com/willhbr/BetterErrors.git", from: "0.0.1"),
```
