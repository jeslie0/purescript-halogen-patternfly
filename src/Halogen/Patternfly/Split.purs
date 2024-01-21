module Halogen.Patternfly.Split (split, splitItem) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Helper (buildOptionsST, PFProp, classList)
import Data.Tuple (Tuple(..))

classNames =
  { split: ClassName "pf-v5-l-split"
  , splitItem: ClassName "pf-v5-l-split__item"
  , gutter: ClassName "pf-m-gutter"
  , wrap: ClassName "pf-m-wrap"
  , filled: ClassName "pf-m-filled"
  }

type SplitOptions :: Row Type
type SplitOptions =
  ( hasGutter :: Boolean
  , isWrappable :: Boolean
  )

initialSplitOptions :: Record SplitOptions
initialSplitOptions =
  { hasGutter: false
  , isWrappable: false
  }

split :: forall w i. Array (PFProp SplitOptions) -> HH.Node HI.HTMLdiv w i
split options attr =
  let
    fullOptions =
      buildOptionsST options initialSplitOptions
  in
    HH.div $
      classList
        [ Tuple classNames.split true
        , Tuple classNames.gutter fullOptions.hasGutter
        , Tuple classNames.wrap fullOptions.isWrappable
        ]
        : attr

--

type SplitItemOptions :: Row Type
type SplitItemOptions =
  ( isFilled :: Boolean
  )

initialSplitItemOptions :: Record SplitItemOptions
initialSplitItemOptions =
  {isFilled: false
  }

splitItem :: forall w i. Array (PFProp SplitItemOptions) -> HH.Node HI.HTMLdiv w i
splitItem options attr =
  let
    fullOptions =
      buildOptionsST options initialSplitItemOptions
  in
    HH.div $
      classList
        [ Tuple classNames.splitItem true
        , Tuple classNames.filled fullOptions.isFilled
        ]
        : attr
