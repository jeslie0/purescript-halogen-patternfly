module Halogen.Patternfly.ToggleGroup (toggleGroup, toggleGroupItem) where

import Prelude

import Control.Alt ((<|>))
import DOM.HTML.Indexed (HTMLdiv)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML (HTML)
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties (ButtonType(..))
import Halogen.HTML.Properties as HP
import Halogen.Patternfly.Properties (buildOptions)
import Helper (PFProp)
import Web.HTML.Common (ClassName(..))
import Web.UIEvent.MouseEvent (MouseEvent)

classNames =
  { toggleGroup: ClassName "pf-v5-c-toggle-group"
  , toggleGroupItem: ClassName "pf-v5-c-toggle-group__item"
  , toggleGroupButton: ClassName "pf-v5-c-toggle-group__button"
  , toggleGroupText: ClassName "pf-v5-c-toggle-group__text"
  , toggleGroupContent: ClassName "pf-v5-c-toggle-group__content"
  , compact: ClassName "pf-m-compact"
  , selected: ClassName "pf-m-selected"
  }

type ToggleGroupOptions :: Row Type
type ToggleGroupOptions =
  ( isCompact :: Boolean
  , areAllGroupsDisabled :: Boolean
  )

initialToggleGroupOptions :: Record ToggleGroupOptions
initialToggleGroupOptions =
  { isCompact: false
  , areAllGroupsDisabled: false
  }

toggleGroup :: forall w i. Array (PFProp ToggleGroupOptions) -> HH.Node HTMLdiv w i
toggleGroup conf attr =
  let
    options =
      buildOptions conf initialToggleGroupOptions
  in
    HH.div $
      [ HP.classes [ classNames.toggleGroup, if options.isCompact then classNames.compact else ClassName "" ]
      , HP.attr (H.AttrName "role") "group"
      ] <> attr

type ToggleGroupItemOptions :: Type -> Type -> Row Type
type ToggleGroupItemOptions w i =
  ( isDisabled :: Boolean
  , isSelected :: Boolean
  , text :: Maybe String
  , content :: Maybe (HTML w i)
  , onClick :: Maybe (MouseEvent -> i)
  )

initialToggleGroupItemOptions :: forall w i . Record (ToggleGroupItemOptions w i)
initialToggleGroupItemOptions =
  { isDisabled: false
  , isSelected: false
  , text: Nothing
  , content: Nothing
  , onClick: Nothing
  }

toggleGroupItem :: forall w i. Array (PFProp (ToggleGroupItemOptions w i)) -> HTML w i
toggleGroupItem conf =
  let
    options =
      buildOptions conf initialToggleGroupItemOptions

    { klass, comp } =
      case
        (options.text <#> \str -> { comp: HH.text str, klass: classNames.toggleGroupText })
          <|> (options.content <#> \comp -> { comp: comp, klass: classNames.toggleGroupContent })
        of
        Nothing -> { klass: ClassName "", comp: [] }
        Just something -> { klass: something.klass, comp: [ something.comp ] }

    onChange =
      case options.onClick of
        Nothing -> []
        Just f -> [ HE.onClick f ]
  in
    HH.div ([ HP.class_ classNames.toggleGroupItem ])
      [ HH.button
          ( [ HP.classes
                [ classNames.toggleGroupButton
                -- , klass
                , if options.isSelected then classNames.selected else ClassName ""
                ]
            , HP.type_ ButtonButton
            , HP.disabled options.isDisabled
            ] <> onChange
          )
          comp
      ]
