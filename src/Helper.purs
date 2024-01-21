module Helper (PFProp(..), buildOptionsST, classList) where

import Prelude

import Data.Array as Array
import Control.Monad.ST (run, foreach)
import Control.Monad.ST.Ref (modify, new, read)
import Data.Tuple (Tuple)
import Data.Tuple as Tuple
import Halogen (ClassName)
import Halogen.HTML.Properties as HP

newtype PFProp r = PFProp (Record r -> Record r)

buildOptionsST :: forall r . Array (PFProp r) -> Record r -> Record r
buildOptionsST opArray init =
  run do
    curOpRef <- new init
    foreach opArray $ \(PFProp func) -> do
      _ <- modify func curOpRef
      pure unit
    read curOpRef

classList :: forall r i . Array (Tuple ClassName Boolean) -> HP.IProp ( class :: String | r ) i
classList classes =
  HP.classes $ Tuple.fst <$> Array.filter Tuple.snd classes
