module Halogen.Patternfly.Icons.EllipsisV (ellipsisV) where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Svg.Attributes as HSA
import Halogen.Svg.Attributes.Color (Color(..))
import Halogen.Svg.Elements as HS

ellipsisV :: forall w i. HH.HTML w i
ellipsisV =
  HS.svg
    [ HSA.class_ $ H.ClassName "pf-v5-svg"
    , HSA.viewBox 0.0 0.0 192.0 512.0
    , HSA.fill $ Named "currentColor"
    , HP.attr (H.AttrName "role") "img"
    , HP.attr (H.AttrName "width") "1em"
    , HP.attr (H.AttrName "height") "1em"
    ]
    [ HS.path [ HP.attr (H.AttrName "d") "M96 184c39.8 0 72 32.2 72 72s-32.2 72-72 72-72-32.2-72-72 32.2-72 72-72zM24 80c0 39.8 32.2 72 72 72s72-32.2 72-72S135.8 8 96 8 24 40.2 24 80zm0 352c0 39.8 32.2 72 72 72s72-32.2 72-72-32.2-72-72-72-72 32.2-72 72z"] ]
