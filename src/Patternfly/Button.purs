module Patternfly.Button where

import Prelude

import DOM.HTML.Indexed (HTMLbutton)
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Halogen.HTML.Properties as HP
import Helper (buildOptionsST, PFProp)

classNames =
  { button: ClassName "pf-v5-c-button"
  , variant:
      { primary: ClassName "pf-m-primary"
      , secondary: ClassName "pf-m-secondary"
      , tertiary: ClassName "pf-m-tertiary"
      , danger: ClassName "pf-m-danger"
      , warning: ClassName "pf-m-warning"
      , link: ClassName "pf-m-link"
      , plain: ClassName "pf-m-plain"
      , control: ClassName "pf-m-control"
      }
  , inline: ClassName "pf-m-inline"
  , danger: ClassName "pf-m-danger"
  , disabled: ClassName "pf-m-disabled"
  , block: ClassName "pf-m-block"
  , large: ClassName "pf-m-display-lg"
  , small: ClassName "pf-m-small"
  }

data Variant
  = Primary
  | Secondary
  | Tertiary
  | Danger
  | Warning
  | Link
  | Plain
  | Control

derive instance eqVariant :: Eq Variant
derive instance ordVariant :: Ord Variant

data Size
  = Small
  | Large

type ButtonOptions :: Row Type
type ButtonOptions =
  ( variant :: Variant
  , isDisabled :: Boolean
  , isDanger :: Boolean
  , size :: Maybe Size
  , isBlock :: Boolean
  , isInline :: Boolean
  -- , countOptions :: CountOptions
  )

initialButtonOptions :: Record ButtonOptions
initialButtonOptions =
  { variant: Primary
  , isDisabled: false
  , isDanger: false
  , size: Nothing
  , isBlock: false
  , isInline: false
  }

getVariantClass :: Variant -> ClassName
getVariantClass Primary = classNames.variant.primary
getVariantClass Secondary = classNames.variant.secondary
getVariantClass Tertiary = classNames.variant.tertiary
getVariantClass Danger = classNames.variant.danger
getVariantClass Warning = classNames.variant.warning
getVariantClass Link = classNames.variant.link
getVariantClass Plain = classNames.variant.plain
getVariantClass Control = classNames.variant.control

button :: forall w i. Array (PFProp ButtonOptions) -> HH.Node HTMLbutton w i
button options attr =
  let
    fullOptions =
      buildOptionsST options initialButtonOptions

    classVariant =
      getVariantClass fullOptions.variant

    { disabledClass, disabledAttr } =
      if fullOptions.isDisabled then { disabledClass: classNames.disabled, disabledAttr: [ HP.disabled true ] }
      else { disabledClass: ClassName "", disabledAttr: [ HP.disabled false ] }

    isDangerAttr =
      if fullOptions.isDanger && (fullOptions.variant == Secondary || fullOptions.variant == Link) then classNames.danger else ClassName ""

    isBlockAttr =
      if fullOptions.isBlock then classNames.block else ClassName ""

    isInlineAttr =
      if fullOptions.isInline then classNames.inline else ClassName ""

    sizeAttr =
      case fullOptions.size of
        Nothing -> ClassName ""
        Just Small -> classNames.small
        Just Large -> classNames.large

  in
    HH.button
      ( [ classes [ classNames.button, classVariant, disabledClass, isDangerAttr, isBlockAttr, isInlineAttr, sizeAttr ] ]
          <> disabledAttr
          <> attr
      )
