module Properties (buildOptions, class_, isCompact, isFlat, isLarge, isRounded, isFullHeight, isPlain, isFilled, pageSectionVariant, sidebar, header, isOpen, usePageInsets, useVariant, isDisabled, isDanger, isBlock, isInline, useSize) where

import Prelude

import Control.Monad.ST (run, foreach)
import Control.Monad.ST.Ref (modify, new, read)
import Patternfly.Page (PageSectionVariant)
import Patternfly.Button as Button
import Helper (PFProp(..))
import Halogen.HTML as HH
import Data.Maybe (Maybe(..))

buildOptions :: forall r. Array (PFProp r) -> Record r -> Record r
buildOptions opArray init =
  run do
    curOpRef <- new init
    foreach opArray $ \(PFProp func) -> do
      _ <- modify func curOpRef
      pure unit
    read curOpRef

class_ :: forall r. String -> PFProp (class_ :: String | r)
class_ str =
  PFProp (\conf -> conf { class_ = str })

isCompact :: forall r. Boolean -> PFProp (isCompact :: Boolean | r)
isCompact bool =
  PFProp (\conf -> conf { isCompact = bool })

isFlat :: forall r. Boolean -> PFProp (isFlat :: Boolean | r)
isFlat bool =
  PFProp (\conf -> conf { isFlat = bool })

isLarge :: forall r. Boolean -> PFProp (isLarge :: Boolean | r)
isLarge bool =
  PFProp (\conf -> conf { isLarge = bool })

isRounded :: forall r. Boolean -> PFProp (isRounded :: Boolean | r)
isRounded bool =
  PFProp (\conf -> conf { isRounded = bool })

isFullHeight :: forall r. Boolean -> PFProp (isFullHeight :: Boolean | r)
isFullHeight bool =
  PFProp (\conf -> conf { isFullHeight = bool })

isPlain :: forall r. Boolean -> PFProp (isPlain :: Boolean | r)
isPlain bool =
  PFProp (\conf -> conf { isPlain = bool })

isFilled :: forall r. Boolean -> PFProp (isFilled :: Boolean | r)
isFilled bool =
  PFProp (\conf -> conf { isFilled = bool })


-- Page section variants

sidebar :: forall r w i . HH.HTML w i -> PFProp (sidebar :: Maybe (HH.HTML w i) | r)
sidebar sdbr =
  PFProp (\conf -> conf { sidebar = Just sdbr})

header :: forall r w i . HH.HTML w i -> PFProp (header :: Maybe (HH.HTML w i) | r)
header hdr =
  PFProp (\conf -> conf { header = Just hdr})

pageSectionVariant :: forall r . PageSectionVariant -> PFProp (pageSectionVariant :: PageSectionVariant | r)
pageSectionVariant var =
  PFProp (\conf -> conf { pageSectionVariant = var })

isOpen :: forall r . Boolean -> PFProp (isOpen :: Boolean | r)
isOpen bool =
  PFProp (\conf -> conf { isOpen = bool })

usePageInsets :: forall r . Boolean -> PFProp (usePageInsets :: Boolean | r)
usePageInsets bool =
  PFProp (\conf -> conf { usePageInsets = bool })


-- * Button

useVariant :: forall r . Button.Variant -> PFProp (variant :: Button.Variant | r)
useVariant var =
  PFProp (\conf -> conf { variant = var })

isDisabled :: forall r . Boolean -> PFProp (isDisabled :: Boolean | r)
isDisabled bool =
  PFProp (\conf -> conf { isDisabled = bool })

isDanger :: forall r . Boolean -> PFProp (isDanger :: Boolean | r)
isDanger bool =
  PFProp (\conf -> conf { isDanger = bool })

isBlock :: forall r . Boolean -> PFProp (isBlock :: Boolean | r)
isBlock bool =
  PFProp (\conf -> conf { isBlock = bool })

isInline :: forall r . Boolean -> PFProp (isBlock :: Boolean | r)
isInline bool =
  PFProp (\conf -> conf { isBlock = bool })

useSize :: forall r . Button.Size -> PFProp (size :: Maybe Button.Size | r)
useSize size =
  PFProp (\conf -> conf { size = Just size })
