## Data.Aeson benchmark of different ToJSON derivations

This is a small project that uses the `criterion` library to compare preformance
of two different ways of deriving the `ToJSON` instances from `Data.Aeson`:

  1) `deriving anyclass ToJSON`
  2) `instance ToJSON Foo where toEncoding = genericToEncoding defaultOptions`

The documentation says that the second way is more performant for reasons, but
the first way is kept as-is for backward compatibility. The results (see
./aeson-bench-results.xlsx) confirm this hypothesis, and further show that there
is a significant difference between optimized and unoptimized code.