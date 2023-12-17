module Helper (buildOptionsST) where

import Prelude
import Properties (PFProp(..))
import Control.Monad.ST (run, foreach)
import Control.Monad.ST.Ref (modify, new, read)

buildOptionsST :: forall r . Array (PFProp r) -> Record r -> Record r
buildOptionsST opArray init =
  run do
    curOpRef <- new init
    foreach opArray $ \(PFProp func) -> do
      _ <- modify func curOpRef
      pure unit
    read curOpRef
