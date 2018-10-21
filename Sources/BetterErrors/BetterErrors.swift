import Foundation

// Stolen from Swift Package Manager
// https://github.com/apple/swift-package-manager/blob/master/Sources/POSIX/Error.swift#L45
func strerror(_ errno: Int32) -> String {
  var cap = 64
  while cap <= 16 * 1024 {
    var buf = [Int8](repeating: 0, count: cap)
    let err = strerror_r(errno, &buf, buf.count)
    if err == EINVAL {
      return "Unknown error \(errno)"
    }
    if err == ERANGE {
      cap *= 2
      continue
    }
    if err != 0 {
      fatalError("strerror_r error: \(err)")
    }
    return "\(String(cString: buf)) (\(errno))"
  }
  fatalError("strerror_r error: \(ERANGE)")
}

extension Error {
  var betterDescription: String {
    if self._domain == NSPOSIXErrorDomain,
      let code = Int32(exactly: self._code) {
      return strerror(code)
    } else {
      return (self as NSError).description
    }
  }
}
