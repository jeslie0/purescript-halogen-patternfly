module Halogen.Patternfly.Stack (stack, stackItem) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Helper (buildOptionsST, PFProp, classList)
import Data.Tuple (Tuple(..))

classNames =
  { stack: ClassName "pf-v5-l-stack"
  , stackItem: ClassName "pf-v5-l-stack__item"
  , gutter: ClassName "pf-m-gutter"
  , wrap: ClassName "pf-m-wrap"
  , filled: ClassName "pf-m-filled"
  }

type StackOptions :: Row Type
type StackOptions =
  ( hasGutter :: Boolean
  )

initialStackOptions :: Record StackOptions
initialStackOptions =
  { hasGutter: false
  }

stack :: forall w i. Array (PFProp StackOptions) -> HH.Node HI.HTMLdiv w i
stack options attr =
  let
    fullOptions =
      buildOptionsST options initialStackOptions
  in
    HH.div $
      classList
        [ Tuple classNames.stack true
        , Tuple classNames.gutter fullOptions.hasGutter
        ]
        : attr

--

type StackItemOptions :: Row Type
type StackItemOptions =
  ( isFilled :: Boolean
  )

initialStackItemOptions :: Record StackItemOptions
initialStackItemOptions =
  {isFilled: false
  }

stackItem :: forall w i. Array (PFProp StackItemOptions) -> HH.Node HI.HTMLdiv w i
stackItem options attr =
  let
    fullOptions =
      buildOptionsST options initialStackItemOptions
  in
    HH.div $
      classList
        [ Tuple classNames.stackItem true
        , Tuple classNames.filled fullOptions.isFilled
        ]
        : attr
