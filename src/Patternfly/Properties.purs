module Properties (buildOptions, PFProp(..), class_, isCompact, isFlat, isLarge, isRounded, isFullHeight, isPlain, isFilled) where

import Prelude

import Control.Monad.ST (run, foreach)
import Control.Monad.ST.Ref (modify, new, read)

newtype PFProp r = PFProp (Record r -> Record r)

buildOptions :: forall r . Array (PFProp r) -> Record r -> Record r
buildOptions opArray init =
  run do
    curOpRef <- new init
    foreach opArray $ \(PFProp func) -> do
      _ <- modify func curOpRef
      pure unit
    read curOpRef


class_ :: forall r . String -> PFProp ( class_ :: String | r)
class_ str =
  PFProp (\conf -> conf { class_ =  str })


isCompact :: forall r . Boolean -> PFProp ( isCompact :: Boolean | r )
isCompact bool =
  PFProp (\conf -> conf { isCompact = bool })

isFlat :: forall r . Boolean -> PFProp ( isFlat :: Boolean | r )
isFlat bool =
  PFProp (\conf -> conf { isFlat = bool })

isLarge :: forall r . Boolean -> PFProp ( isLarge :: Boolean | r )
isLarge bool =
  PFProp (\conf -> conf { isLarge = bool })

isRounded :: forall r . Boolean -> PFProp ( isRounded :: Boolean | r )
isRounded bool =
  PFProp ( \conf -> conf { isRounded = bool })

isFullHeight :: forall r . Boolean -> PFProp ( isFullHeight :: Boolean | r )
isFullHeight bool =
  PFProp ( \conf -> conf { isFullHeight = bool })

isPlain :: forall r . Boolean -> PFProp ( isPlain :: Boolean | r )
isPlain bool =
  PFProp (\conf -> conf { isPlain = bool })




isFilled :: forall r . Boolean -> PFProp ( isFilled :: Boolean | r)
isFilled bool =
  PFProp ( \conf -> conf { isFilled = bool })
