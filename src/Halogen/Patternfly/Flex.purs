module Halogen.Patternfly.Flex (flex, flexItem) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Helper (buildOptionsST, PFProp, classList)
import Data.Tuple (Tuple(..))

classNames =
  { flex: ClassName "pf-v5-l-flex"
  , column: ClassName "pf-m-column"
  , rowLarge: ClassName "pf-m-row-on-lg"
  }

type FlexOptions :: Row Type
type FlexOptions =
  ()

initialFlexOptions :: Record FlexOptions
initialFlexOptions =
  {}

flex :: forall w i. Array (PFProp FlexOptions) -> HH.Node HI.HTMLdiv w i
flex options attr =
  let
    fullOptions =
      buildOptionsST options initialFlexOptions
  in
    HH.div $
      classList
        [ Tuple classNames.flex true
        ]
        : attr

--

type SplitItemOptions :: Row Type
type SplitItemOptions =
  ()

initialSplitItemOptions :: Record SplitItemOptions
initialSplitItemOptions =
  {}

flexItem :: forall w i. Array (PFProp SplitItemOptions) -> HH.Node HI.HTMLdiv w i
flexItem options attr =
  let
    fullOptions =
      buildOptionsST options initialSplitItemOptions
  in
    HH.div $
      attr
