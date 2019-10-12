module Producer where

import Buffer
import Data.Serialize hiding (get, put)
import Control.Monad.Trans.Reader
import Control.Monad.Trans.State.Strict
import Control.Monad.Trans.Class (lift)

keepProducing :: Int -> StateT [Int] (ReaderT FilePath IO) () 
keepProducing i = do
  b <- get
  if length b > 5000
    then lift (persist (encode b))
      >> liftIO (print "Producer: Persisted")
      >> put []
      >> liftIO (print "Producer: Emtied cache")
      >> keepProducing i
    else modify (i:)
      >> liftIO (print ("Producer: Added " ++ show i ++ " to cache"))
      >> keepProducing (i + 1)
  where
    liftIO = lift . lift


  



