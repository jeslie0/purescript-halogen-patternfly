module Halogen.Patternfly.Gallery (gallery) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Helper (buildOptionsST, PFProp)

classNames =
  { gallery: ClassName "pf-v5-l-gallery"
  , gutter: ClassName "pf-m-gutter"
  }

type GalleryOptions :: Row Type
type GalleryOptions =
  ( hasGutter :: Boolean
  , minWidths ::
      { default_ :: Maybe String
      , sm :: Maybe String
      , md :: Maybe String
      , lg :: Maybe String
      , xl :: Maybe String
      , xl2 :: Maybe String
      }
  )

initialGalleryOptions :: Record GalleryOptions
initialGalleryOptions =
  { hasGutter: false
  , minWidths:
      { default_: Nothing
      , sm: Nothing
      , md: Nothing
      , lg: Nothing
      , xl: Nothing
      , xl2: Nothing
      }
  }

gallery :: forall w i. Array (PFProp GalleryOptions) -> HH.Node HI.HTMLdiv w i
gallery options attr =
  let
    fullOptions =
      buildOptionsST options initialGalleryOptions

    gutterClass =
      if fullOptions.hasGutter then classNames.gutter else ClassName ""
  in
    HH.div $ classes [ classNames.gallery, gutterClass ] : attr
