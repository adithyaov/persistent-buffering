# Read Me :-)

**Nomenclature**

Buffer :- Persisted memory (file system)

Cache :- In memory (ram)

**Producer Logic**

1. Producer keeps producing items to their local cache.

2. When the local cache is full (5000 items in this case) the producer
   serializes the cache and saves it to the file system (buffer) with the
   current timestamp.

**Consumer Logic**

1. Consumer keeps consuming items from their local cache.

2. When the local cache is empty they look up the file system
   to get the least recent (timestamp) buffer file to replace the cache.








