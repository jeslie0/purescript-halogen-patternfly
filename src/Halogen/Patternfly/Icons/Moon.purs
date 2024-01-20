module Halogen.Patternfly.Icons.Moon (moon) where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Svg.Attributes as HSA
import Halogen.Svg.Attributes.Color (Color(..))
import Halogen.Svg.Elements as HS

moon :: forall w i. HH.HTML w i
moon =
  HS.svg
    [ HSA.class_ $ H.ClassName "pf-v5-svg"
    , HSA.viewBox 0.0 0.0 512.0 512.0
    , HSA.fill $ Named "currentColor"
    , HP.attr (H.AttrName "role") "img"
    , HP.attr (H.AttrName "width") "1em"
    , HP.attr (H.AttrName "height") "1em"
    ]
    [ HS.path [ HP.attr (H.AttrName "d") "M283.211 512c78.962 0 151.079-35.925 198.857-94.792 7.068-8.708-.639-21.43-11.562-19.35-124.203 23.654-238.262-71.576-238.262-196.954 0-72.222 38.662-138.635 101.498-174.394 9.686-5.512 7.25-20.197-3.756-22.23A258.156 258.156 0 0 0 283.211 0c-141.309 0-256 114.511-256 256 0 141.309 114.511 256 256 256z" ] ]
