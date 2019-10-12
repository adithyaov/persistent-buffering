module Main where

import Producer
import Consumer
import Control.Monad
import Control.Concurrent (forkIO, threadDelay)
import Control.Monad.Trans.Reader
import Control.Monad.Trans.State.Strict

bufferPath =
  "/mnt/c/Users/mota/Desktop/LinuxWorkStation/Prog/persistent-buffering/buffer"

run s = void $ runReaderT (execStateT s []) bufferPath

main = do
  forkIO $ run $ keepProducing 0
  forkIO $ run keepConsuming
  threadDelay (3 * 1000000)




