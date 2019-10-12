module Consumer where

import Buffer
import Data.Serialize hiding (get, put)
import Control.Monad.Trans.Reader
import Control.Monad.Trans.State.Strict
import Control.Monad.Trans.Class (lift)

keepConsuming :: StateT [Int] (ReaderT FilePath IO) ()
keepConsuming = do
  b <- get
  if null b
     then do
       ea <- lift readP 
       liftIO (print "Reading from Persisted")
       case ea of
         Left err -> liftIO (print err)
         Right bl -> put bl
       keepConsuming
     else liftIO (print ("Consumed " ++ show (head b)))
       >> put (tail b) 
       >> keepConsuming
  where
    liftIO = lift . lift

  



