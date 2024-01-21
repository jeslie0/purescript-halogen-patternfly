module Halogen.Patternfly.Menu.Menu (menu, menuContent, menuItem, menuList) where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML (IProp)
import Halogen.HTML.Events as HE
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_)
import Halogen.HTML.Properties as HP
import Helper (buildOptionsST, PFProp, classList)
import Web.UIEvent.MouseEvent (MouseEvent)

classNames =
  { menu: ClassName "pf-v5-c-menu"
  , menuContent: ClassName "pf-v5-c-menu__content"
  , menuList: ClassName "pf-v5-c-menu__list"
  , menuListItem: ClassName "pf-v5-c-menu__list-item"
  , menuItem: ClassName "pf-v5-c-menu__item"
  , menuItemMain: ClassName "pf-v5-c-menu__item-main"
  , menuItemText: ClassName "pf-v5-c-menu__item-text"
  , disabled: ClassName "pf-m-disabled"
  , plainMenu: ClassName "pf-m-plain"
  , scrollable: ClassName "pf-m-scrollable"
  }

type MenuOptions :: Row Type
type MenuOptions =
  ( isPlain :: Boolean
  , isRootMenu :: Boolean
  , isScrollable :: Boolean
  , isHidden :: Boolean
  )

initialMenuOptions :: Record MenuOptions
initialMenuOptions =
  { isPlain: false
  , isRootMenu: false
  , isScrollable: false
  , isHidden: true
  }

menu :: forall w i. Array (PFProp MenuOptions) -> HH.Node HI.HTMLdiv w i
menu options attr =
  let
    fullOptions =
      buildOptionsST options initialMenuOptions

    attributes =
      classList
        [ Tuple classNames.menu true
        , Tuple classNames.plainMenu fullOptions.isPlain
        , Tuple classNames.scrollable fullOptions.isScrollable
        ] : HP.style "position: absolute" : attr

    fullAttributes =
      if (fullOptions.isHidden) then
        HP.attr (H.AttrName "hidden") "" : attributes
      else attributes

  in
    HH.div fullAttributes

type MenuContentOptions :: Row Type
type MenuContentOptions =
  ()

initialMenuContentOptions :: Record MenuContentOptions
initialMenuContentOptions =
  {}

menuContent :: forall w i. Array (PFProp MenuContentOptions) -> HH.Node HI.HTMLdiv w i
menuContent options attr =
  let
    fullOptions =
      buildOptionsST options initialMenuContentOptions
  in
    HH.div $
      class_ classNames.menuContent
        : attr

type MenuListOptions :: Row Type
type MenuListOptions =
  ()

initialMenuListOptions :: Record MenuListOptions
initialMenuListOptions =
  {}

menuList :: forall w i. Array (PFProp MenuListOptions) -> HH.Node HI.HTMLul w i
menuList options attr =
  let
    fullOptions =
      buildOptionsST options initialMenuListOptions
  in
    HH.ul $
      [ class_ classNames.menuList, HP.attr (H.AttrName "role") "menu" ] <> attr

--

type MenuItemOptions :: Type -> Row Type
type MenuItemOptions i =
  ( isDisabled :: Boolean
  , onClick :: Maybe (MouseEvent -> i)
  )

initialMenuItemOptions :: forall i. Record (MenuItemOptions i)
initialMenuItemOptions =
  { isDisabled: false
  , onClick: Nothing
  }

menuItem :: forall w i. Array (PFProp (MenuItemOptions i)) -> String -> HH.HTML w i
menuItem options str =
  let
    fullOptions =
      buildOptionsST options initialMenuItemOptions

    onClick =
      case fullOptions.onClick of
        Nothing -> []
        Just f -> [ HE.onClick f ]
  in
    HH.li
      [ classList [ Tuple classNames.menuListItem true, Tuple classNames.disabled fullOptions.isDisabled ] ]
      [ HH.button (class_ classNames.menuItem : onClick)
          [ HH.span [ class_ classNames.menuItemText ]
              [ HH.text str ]
          ]
      ]
