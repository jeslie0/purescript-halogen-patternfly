module Patternfly.Icons.BarsIcon (barsIcon) where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Svg.Attributes as HSA
import Halogen.Svg.Attributes.Color (Color(..))
import Halogen.Svg.Elements as HS

barsIcon :: forall w i. HH.HTML w i
barsIcon =
  HS.svg
    [ HSA.class_ $ H.ClassName "pf-v5-svg"
    , HSA.viewBox 0.0 0.0 448.0 512.0
    , HSA.fill $ Named "currentColor"
    , HP.attr (H.AttrName "role") "img"
    , HP.attr (H.AttrName "width") "1em"
    , HP.attr (H.AttrName "height") "1em"
    , HP.attr (H.AttrName "color") "var(--pf-v5-global--Color-100)"
    ]
    [ HS.path [ HP.attr (H.AttrName "d") "M16 132h416c8.837 0 16-7.163 16-16V76c0-8.837-7.163-16-16-16H16C7.163 60 0 67.163 0 76v40c0 8.837 7.163 16 16 16zm0 160h416c8.837 0 16-7.163 16-16v-40c0-8.837-7.163-16-16-16H16c-8.837 0-16 7.163-16 16v40c0 8.837 7.163 16 16 16zm0 160h416c8.837 0 16-7.163 16-16v-40c0-8.837-7.163-16-16-16H16c-8.837 0-16 7.163-16 16v40c0 8.837 7.163 16 16 16z" ] ]
