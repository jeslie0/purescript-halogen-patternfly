module Halogen.Patternfly.Tabs (tabs, tabItem) where

import Prelude

import DOM.HTML.Indexed as HI
import DOM.HTML.Indexed.ButtonType (ButtonType(..))
import Data.Array ((:))
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Halogen (ClassName(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties (class_, type_)
import Halogen.HTML.Properties as HP
import Helper (buildOptionsST, PFProp, classList)
import Web.UIEvent.MouseEvent (MouseEvent)

classNames =
  { tabs: ClassName "pf-v5-c-tabs"
  , tabsList: ClassName "pf-v5-c-tabs__list"
  , tabsButton: ClassName "pf-v5-c-tabs__link"
  , tabItem: ClassName "pf-v5-c-tabs__item"
  , tabItemText: ClassName "pf-v5-c-tabs__item-text"
  , box: ClassName "pf-m-box"
  , selected: ClassName "pf-m-current"
  }

type TabsOptions :: Row Type
type TabsOptions =
  (isBox :: Boolean)

initialTabsOptions :: Record TabsOptions
initialTabsOptions =
  { isBox: false }

tabs :: forall w i. Array (PFProp TabsOptions) -> HH.Node HI.HTMLdiv w i
tabs options attr children =
  let
    fullOptions =
      buildOptionsST options initialTabsOptions
  in
    HH.div
      ( (classList
          [ Tuple classNames.tabs true
          , Tuple classNames.box fullOptions.isBox
          ])
          : (HP.attr (H.AttrName "role") "region") : attr
      )
      [ HH.ul [ class_ classNames.tabsList ] children ]

type TabItemOptions :: Type -> Row Type
type TabItemOptions i =
  ( onClick :: Maybe (MouseEvent -> i)
  , isSelected :: Boolean
  )

initialTabItemOptions :: forall i. Record (TabItemOptions i)
initialTabItemOptions =
  { onClick: Nothing
  , isSelected: false
  }

tabItem :: forall w i. Array (PFProp (TabItemOptions i)) -> String -> HH.HTML w i
tabItem options str =
  let
    fullOptions =
      buildOptionsST options initialTabItemOptions

    onClick =
      case fullOptions.onClick of
        Nothing -> []
        Just f -> [ HE.onClick f ]
  in
    HH.li
      ( onClick <>
          [ classList [ Tuple classNames.tabItem true, Tuple classNames.selected fullOptions.isSelected ]
          , HP.attr (H.AttrName "role") "presentation"
          ]
      )
      [ HH.button [ class_ classNames.tabsButton, type_ ButtonButton ]
          [ HH.span [ class_ classNames.tabItemText ] [ HH.text str ]
          ]
      ]
