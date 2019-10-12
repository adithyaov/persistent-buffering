# Design document for Persistent Streams

1. Producer produces
2. Consumer consumes

Need persistent buffering in between.

P -> B.M -> C

P -> B.M -> B.P -> B.M -> C

Serialize -> Save with TS

Most basic thing

Reader monad?

PROBLEM: Consumer needs to wait till the entire file is written.
