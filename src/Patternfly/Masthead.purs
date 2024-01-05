module Patternfly.Masthead (masthead, mastheadBrand, mastheadMain, mastheadToggle, mastheadContent, BackgroundColour(..)) where

import Prelude

import DOM.HTML.Indexed (HTMLheader, HTMLspan, HTMLdiv)
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Helper (buildOptionsST, PFProp)

classNames =
  { masthead: ClassName "pf-v5-c-masthead"
  , inline: ClassName "pf-m-display-inline"
  , toggle: ClassName "pf-v5-c-masthead__toggle"
  , main: ClassName "pf-v5-c-masthead__main"
  , brand: ClassName "pf-v5-c-masthead__prand"
  , content: ClassName "pf-v5-c-masthead__content"
  }

data BackgroundColour
  = Dark
  | Light
  | Light200

type MastheadOptions :: Row Type
type MastheadOptions =
  ( backgroundColor :: BackgroundColour
  , display :: { default_ :: Maybe String, sm :: Maybe String, md :: Maybe String, lg :: Maybe String, xl :: Maybe String, xl2 :: Maybe String }
  )

-- TODO: backgroundColor, display, inset
initialMastheadOptions :: Record MastheadOptions
initialMastheadOptions =
  { backgroundColor: Dark
  , display:
      { default_: Nothing
      , sm: Nothing
      , md: Just "Inline"
      , lg: Nothing
      , xl: Nothing
      , xl2: Nothing
      }
  }

masthead :: forall w i. Array (PFProp MastheadOptions) -> HH.Node HTMLheader w i
masthead options attr children =
  let
    fullOptions =
      buildOptionsST options initialMastheadOptions
  in
    HH.header ([ classes [ classNames.masthead, classNames.inline ] ] <> attr) children

--

type MastheadMainOptions :: Row Type
type MastheadMainOptions =
  ()

mastheadMain :: forall w i. Array (PFProp MastheadMainOptions) -> HH.Node HTMLspan w i
mastheadMain arr props =
  HH.span ([ class_ classNames.main ] <> props)

--

type MastheadContentOptions :: Row Type
type MastheadContentOptions =
  ()

mastheadContent :: forall w i. Array (PFProp MastheadContentOptions) -> HH.Node HTMLdiv w i
mastheadContent arr props =
  HH.div ([ class_ classNames.content ] <> props)

--

type MastheadBrandOptions :: Row Type
type MastheadBrandOptions =
  ()

-- TODO component

mastheadBrand :: forall w i. Array (PFProp MastheadBrandOptions) -> HH.Node HTMLspan w i
mastheadBrand arr props =
  HH.span ([ class_ classNames.brand ] <> props)

--

type MastheadToggleOptions :: Row Type
type MastheadToggleOptions =
  ()

mastheadToggle :: forall w i. Array (PFProp MastheadToggleOptions) -> HH.Node HTMLspan w i
mastheadToggle arr props =
  HH.span ([ class_ classNames.toggle ] <> props)
