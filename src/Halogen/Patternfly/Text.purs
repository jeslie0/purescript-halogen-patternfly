module Halogen.Patternfly.Text (textContent) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Helper (buildOptionsST, PFProp)

classNames =
  { textContent: ClassName "pf-v5-c-content"
  }

type TextContentOptions :: Row Type
type TextContentOptions =
  ( )

initialTextContentOptions :: Record TextContentOptions
initialTextContentOptions =
  { }

textContent :: forall w i. Array (PFProp TextContentOptions) -> HH.Node HI.HTMLdiv w i
textContent options attr =
  let
    fullOptions =
      buildOptionsST options initialTextContentOptions

  in
    HH.div $ class_ classNames.textContent : attr
