module Halogen.Patternfly.Toolbar (toolbar, toolbarContent, toolbarGroup, toolbarItem, separator) where

import Prelude

import DOM.HTML.Indexed (HTMLdiv)
import Data.Maybe (Maybe(..))
import Data.Array ((:))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Halogen.HTML.Properties as HP
import Helper (buildOptionsST, PFProp)
import Halogen.Patternfly.Properties (Alignment(..))

classNames =
  { toolbar: ClassName "pf-v5-c-toolbar"
  , toolbarContent: ClassName "pf-v5-c-toolbar__content"
  , toolbarContentSection: ClassName "pf-v5-c-toolbar__content-section"
  , toolbarGroup: ClassName "pf-v5-c-toolbar__group"
  , toolbarItem: ClassName "pf-v5-c-toolbar__item"
  , rightAlign: ClassName "pf-m-align-right"
  , divider: ClassName "pf-v5-c-divider pf-m-vertical"
  }

type ToolbarOptions :: Row Type
type ToolbarOptions =
  ()

initialToolbarOptions :: Record ToolbarOptions
initialToolbarOptions =
  {}

toolbar :: forall w i . Array (PFProp ToolbarOptions) -> HH.Node HTMLdiv w i
toolbar options attr =
  let
    fullOptions =
      buildOptionsST options initialToolbarOptions
  in
   HH.div $ class_ classNames.toolbar : attr

--


type ToolbarContentOptions :: Row Type
type ToolbarContentOptions =
  ()

initialToolbarContentOptions :: Record ToolbarContentOptions
initialToolbarContentOptions =
  {}

toolbarContent :: forall w i . Array (PFProp ToolbarContentOptions) -> HH.Node HTMLdiv w i
toolbarContent options attr children =
  let
    fullOptions =
      buildOptionsST options initialToolbarContentOptions
  in
   HH.div (class_ classNames.toolbarContent : attr)
   [ HH.div [ class_ classNames.toolbarContentSection] children ]

--

type ToolbarItemOptions :: Row Type
type ToolbarItemOptions =
  ()

initialToolbarItemOptions :: Record ToolbarItemOptions
initialToolbarItemOptions =
  {}

toolbarItem :: forall w i . Array (PFProp ToolbarItemOptions) -> HH.Node HTMLdiv w i
toolbarItem options attr =
  let
    fullOptions =
      buildOptionsST options initialToolbarItemOptions
  in
   HH.div (class_ classNames.toolbarItem : attr)

--

type ToolbarGroupOptions :: Row Type
type ToolbarGroupOptions =
  (alignment :: Alignment)

initialToolbarGroupOptions :: Record ToolbarGroupOptions
initialToolbarGroupOptions =
  { alignment: Left }

toolbarGroup :: forall w i . Array (PFProp ToolbarGroupOptions) -> HH.Node HTMLdiv w i
toolbarGroup options attr =
  let
    fullOptions =
      buildOptionsST options initialToolbarGroupOptions

    alignmentClass =
      case fullOptions.alignment of
        Left -> ClassName ""
        Right -> classNames.rightAlign
  in
   HH.div (classes [classNames.toolbarGroup, alignmentClass ] : attr)

--

separator :: forall w i. HH.HTML w i
separator = HH.hr [class_ classNames.divider]
