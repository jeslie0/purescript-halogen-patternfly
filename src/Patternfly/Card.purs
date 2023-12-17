module Patternfly.Card (card, header, body, footer, title, BodyOptions) where

import Prelude

import Properties (buildOptions)

import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp)
import Halogen.HTML as HH
import Halogen as H
import Halogen.HTML.Properties as HP
import Web.HTML.Common (ClassName(..))
import Helper (PFProp)

classNames =
  { card: "pf-v5-c-card"
  , cardCompact: "pf-m-compact"
  , cardFlat: "pf-m-flat"
  , cardRounded: "pf-m-rounded"
  , cardLarge: "pf-m-display-lg"
  , cardFullHeight: "pf-m-full-height"
  , cardPlain: "pf-m-plain"

  , title: "pf-v5-c-card__title"
  , titleText: "pf-v5-c-card__title-text"
  , header: "pf-v5-c-card__header"
  , body: "pf-v5-c-card__body"
  , bodyNoFill: "pf-m-no-fill"
  , footer: "pf-v5-c-card__footer"
  }

type CardOptions :: Row Type
type CardOptions =
  ( isCompact :: Boolean
  , isFlat :: Boolean
  , isLarge :: Boolean
  , isRounded :: Boolean
  , isFullHeight :: Boolean
  , isPlain :: Boolean
  )

initialCardOptions :: Record CardOptions
initialCardOptions =
  { isCompact: false
  , isFlat: false
  , isLarge: false
  , isRounded: false
  , isFullHeight: true
  , isPlain: false
  }

makeClassNameFromBool :: String -> Boolean -> H.ClassName
makeClassNameFromBool str bool =
  H.ClassName
    if bool then str
    else ""

card :: forall w i. Array (PFProp CardOptions) -> HH.Node HTMLdiv w i
card conf attr =
  let
    options =
      buildOptions conf initialCardOptions

    compactClass =
      makeClassNameFromBool classNames.cardCompact options.isCompact

    flatClass =
      makeClassNameFromBool classNames.cardFlat options.isFlat

    largeClass =
      makeClassNameFromBool classNames.cardLarge options.isLarge

    roundedClass =
      makeClassNameFromBool classNames.cardRounded options.isRounded

    fullHeightClass =
      makeClassNameFromBool classNames.cardFullHeight options.isFullHeight

    plainClass =
      makeClassNameFromBool classNames.cardPlain options.isPlain
  in
    HH.div (attr <> [ HP.classes [ ClassName classNames.card, compactClass, flatClass, largeClass, roundedClass, fullHeightClass, plainClass ] ])

title
  :: forall w i r25 i26
   . (Array (IProp (class :: String | r25) i26) -> Array (HTML w i) -> HTML w i)
  -> String
  -> HTML w i
title elem string =
  HH.div
    [ HP.class_ (ClassName classNames.title) ]
    [ elem
        [ HP.class_ (ClassName classNames.titleText) ]
        [ HH.text string ]
    ]

header :: forall w i. HH.Node HTMLdiv w i
header attr =
  HH.div (attr <> [ HP.class_ (ClassName classNames.header) ])

type BodyOptions =
  (isFilled :: Boolean)

initialBodyOptions :: Record BodyOptions
initialBodyOptions =
  { isFilled: true }

body :: forall w i. Array (PFProp BodyOptions) -> HH.Node HTMLdiv w i
body arr attr =
  let
    bodyOptions =
      buildOptions arr initialBodyOptions

    isFilledClass =
      ClassName $ if bodyOptions.isFilled then "" else classNames.bodyNoFill
  in
    HH.div $ attr <> [ HP.classes [ isFilledClass, ClassName classNames.body ] ]

footer :: forall w i. HH.Node HTMLdiv w i
footer attr =
  HH.div (attr <> [ HP.class_ (ClassName classNames.footer) ])
