module Buffer where

import System.IO
import System.Directory
import Data.Serialize
import Control.Monad.Trans.Reader
import qualified Data.ByteString as BS
import Data.Time.Clock.POSIX (getPOSIXTime)
import Control.Monad.Trans.Class (lift)

-- | Get a millisecond-precision unix timestamp as a 'String'
getTime :: IO String
getTime = show . round <$> getPOSIXTime

persist :: BS.ByteString -> ReaderT FilePath IO ()
persist bs = do
  fp <- ask
  ts <- lift getTime
  lift $ BS.writeFile (fp ++ '/':ts) bs

readP :: (Serialize a) => ReaderT FilePath IO (Either String a)
readP = do 
  fp <- ask
  fs <- lift $ listDirectory fp
  let f = case fs of
            [] -> Left "The buffer is empty"
            x -> Right (minimum x)
  lift $ decode' $ readFile' fp <$> f
  where
    readFile' fp x = do
      y <- BS.readFile (fp ++ '/':x)
      removeFile (fp ++ '/':x)
      return y
    decode' (Left s) = return $ Left s
    decode' (Right bs) = decode <$> bs


    

