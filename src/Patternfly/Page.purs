module Patternfly.Page (page, pageSection, PageSectionVariant(..), sidebar, SidebarOptions, sidebarBody) where

import Prelude

import DOM.HTML.Indexed (HTMLdiv)
import Data.Maybe (Maybe(..))
import Halogen (ClassName(..))
import Halogen.HTML (HTML)
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Helper (buildOptionsST, PFProp)

classNames =
  { page: ClassName "pf-v5-c-page"
  , pageMain: ClassName "pf-v5-c-page__main"
  , pageSection: ClassName "pf-v5-c-page__main-section"
  , pageSectionVariants: { default_: ClassName ""
                         , light: ClassName "pf-m-light"
                         , dark: ClassName "pf-m-dark-200"
                         , darker: ClassName "pf-m-dark-100"}
  , pageSidebar: ClassName "pf-v5-c-page__sidebar"
  , pageSidebarOpen: ClassName "pf-m-expanded"
  , pageSidebarClosed: ClassName "pf-m-collapsed"
  , pageSidebarBody: ClassName "pf-v5-c-page__sidebar-body"
  }

type PageOptions :: Type -> Type -> Row Type
type PageOptions w i =
  ( header :: Maybe (HTML w i)
  , sidebar :: Maybe (HTML w i))

initialPageOptions :: forall w i . Record (PageOptions w i)
initialPageOptions =
  { header: Nothing
  , sidebar: Nothing }


page :: forall w i . Array (PFProp (PageOptions w i)) -> HH.Node HTMLdiv w i
page options attr children =
  let

    fullOptions =
      buildOptionsST options initialPageOptions

    pageHeader =
      case fullOptions.header of
        Nothing -> []
        Just hdr -> [hdr]

    pageSidebar =
      case fullOptions.sidebar of
        Nothing -> []
        Just sidebar -> [sidebar]

  in
  HH.div
  ([ class_ classNames.page ] <> attr)
  $ pageHeader <> pageSidebar <>
  [ HH.div
    [class_ classNames.pageMain]
    children
  ]

-- * Page Section

data PageSectionVariant =
  Default | Light | Dark | Darker

type PageSectionOptions :: Row Type
type PageSectionOptions =
  ( pageSectionVariant :: PageSectionVariant
  , hasOverflowScroll :: Boolean
  , hasShadowBottom :: Boolean
  , hasShadowTop :: Boolean
  , isCenterAligned :: Boolean
  , isFilled :: Boolean
  , isWidthLimited:: Boolean
  -- , sectionType ::
       )

initialPageSectionOptions :: Record PageSectionOptions
initialPageSectionOptions =
  { pageSectionVariant: Default
  , hasOverflowScroll: false
  , hasShadowBottom : false
  , hasShadowTop: false
  , isCenterAligned: false
  , isFilled: false
  , isWidthLimited: false
  }


makePageSectionVariantClassName :: PageSectionVariant -> ClassName
makePageSectionVariantClassName Default = classNames.pageSectionVariants.default_
makePageSectionVariantClassName Light = classNames.pageSectionVariants.light
makePageSectionVariantClassName Dark = classNames.pageSectionVariants.dark
makePageSectionVariantClassName Darker = classNames.pageSectionVariants.darker


pageSection :: forall w i . Array (PFProp PageSectionOptions) -> HH.Node HTMLdiv w i
pageSection options attr children =
  let
    fullOptions = buildOptionsST options initialPageSectionOptions

    sectionClassName = makePageSectionVariantClassName fullOptions.pageSectionVariant
  in
   HH.section
   [ classes [classNames.pageSection, sectionClassName] ]
   children



-- Page sidebar
type SidebarOptions :: Row Type
type SidebarOptions =
  (isOpen :: Boolean)

initialSidebarOptions :: Record SidebarOptions
initialSidebarOptions =
  {isOpen: true}

sidebar :: forall w i . Array (PFProp SidebarOptions) -> HH.Node HTMLdiv w i
sidebar options attr children =
  let
    fullOptions =
      buildOptionsST options initialSidebarOptions

    openClassName =
      if fullOptions.isOpen then classNames.pageSidebarOpen else classNames.pageSidebarClosed

    sidebarClass = classNames.pageSidebar
    in
  HH.div ([classes [sidebarClass, openClassName]] <> attr) children


-- Sidebar body

sidebarBody :: forall w i . HH.Node HTMLdiv w i
sidebarBody attr children =
  HH.div ([class_ classNames.pageSidebarBody] <> attr) children
