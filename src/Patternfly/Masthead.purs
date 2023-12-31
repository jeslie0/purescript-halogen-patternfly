module Patternfly.Masthead (masthead, mastheadBrand, mastheadMain, mastheadToggle, mastheadContent) where

import Prelude

import DOM.HTML.Indexed (HTMLheader, HTMLspan, HTMLdiv)
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML (HTML)
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


type MastheadOptions :: Row Type
type MastheadOptions =
  ()

initialMastheadOptions :: Record MastheadOptions
initialMastheadOptions = {}

masthead :: forall w i. Array (PFProp MastheadOptions) -> HH.Node HTMLheader w i
masthead options attr children =
  let
    fullOptions =
      buildOptionsST options initialMastheadOptions
  in
    HH.header ([ classes [classNames.masthead, classNames.inline] ] <> attr) children

--

type MastheadMainOptions :: Row Type
type MastheadMainOptions =
  ()

mastheadMain :: forall w i. Array (PFProp MastheadMainOptions) -> HH.Node HTMLspan w i
mastheadMain arr props =
  HH.span ([ class_ classNames.main ] <>props)

--

type MastheadContentOptions :: Row Type
type MastheadContentOptions =
  ()

mastheadContent :: forall w i. Array (PFProp MastheadContentOptions) -> HH.Node HTMLdiv w i
mastheadContent arr props =
  HH.div ([class_ classNames.content] <> props)
--

type MastheadBrandOptions :: Row Type
type MastheadBrandOptions =
  ()

mastheadBrand :: forall w i. Array (PFProp MastheadBrandOptions) -> HH.Node HTMLspan w i
mastheadBrand arr props =
  HH.span ([class_ classNames.brand] <> props)

--

type MastheadToggleOptions :: Row Type
type MastheadToggleOptions =
  ()

mastheadToggle :: forall w i. Array (PFProp MastheadToggleOptions) -> HH.Node HTMLspan w i
mastheadToggle arr props =
  HH.span ([ class_ classNames.toggle ] <>props)
