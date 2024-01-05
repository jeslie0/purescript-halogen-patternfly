module Main where

import Prelude

import Effect (Effect)
import Effect.Class (class MonadEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import Patternfly.Card as Card
import Patternfly.Grid as Grid
import Patternfly.Icons.BarsIcon (barsIcon)
import Patternfly.Masthead as Masthead
import Patternfly.Page as Page
import Patternfly.Button as Button
import Prim.Boolean (True, False)
import Properties as P

main :: Effect Unit
main =
  HA.runHalogenAff do
    body <- HA.awaitBody
    runUI component unit body

component :: forall query input output m. MonadEffect m => H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render: HH.lazy render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

-- | MODEL

type Model =
  { isSidebarOpen :: Boolean
  , buttonVariant :: Button.Variant
  }

initialState :: forall input. input -> Model
initialState _ =
  { isSidebarOpen: false
  , buttonVariant: Button.Primary
  }

-- | UPDATE

data Action
  = ToggleSidebar
  | ChangeVariant

handleAction :: forall output m. MonadEffect m => Action -> H.HalogenM Model Action () output m Unit
handleAction action =
  case action of
    ToggleSidebar -> do
      H.modify_ $ \model -> model { isSidebarOpen = not model.isSidebarOpen }

    ChangeVariant -> do
      H.modify_ $ \model -> model
        { buttonVariant = case model.buttonVariant of
            Button.Primary -> Button.Secondary
            Button.Secondary -> Button.Tertiary
            Button.Tertiary -> Button.Danger
            Button.Danger -> Button.Warning
            Button.Warning -> Button.Link
            Button.Link -> Button.Plain
            Button.Plain -> Button.Control
            Button.Control -> Button.Primary
        }

-- | VIEW

render :: forall m. Model -> H.ComponentHTML Action () m
render model =
  Page.page
    [ P.sidebar $ Page.sidebar [ P.isOpen model.isSidebarOpen ] [] [ Page.sidebarBody [ P.usePageInsets true ] [] [ HH.text "This is the sidebar" ] ]
    , P.header $
        Masthead.masthead
          []
          []
          [ Masthead.mastheadToggle [] [] [ HH.button [ HE.onClick (const ToggleSidebar), HP.classes [ H.ClassName "pf-v5-c-button", H.ClassName "pf-m-plain" ] ] [ barsIcon ] ]
          , Masthead.mastheadMain [] [] [ Masthead.mastheadBrand [] [] [ HH.text "Logo" ] ]
          , Masthead.mastheadContent [] [] [ HH.span [] [ HH.text "Content" ] ]
          ]
    ]
    []
    [ Page.pageSection
        [ P.pageSectionVariant Page.Darker ]
        []
        [ HH.text "HELLO" ]
    , Page.pageSection
        [ P.pageSectionVariant Page.Dark ]
        []
        [ HH.text "HELLO" ]
    , Page.pageSection
        [ P.pageSectionVariant Page.Light ]
        []
        [ HH.text "HELLO" ]
    , Page.pageSection
        [ P.pageSectionVariant Page.Default ]
        []
        [ Button.button
            [ P.useVariant model.buttonVariant
            , P.useSize Button.Small ]
            [ HE.onClick $ const ChangeVariant ]
            [ HH.text "hi" ]
        ]

    -- [ Card.card [ P.isFullHeight true ]
    --     []
    --     [ Card.title HH.h1 "Title"
    --     , Card.header [] [ HH.text "Header" ]
    --     , Card.body [ P.isFilled false ] [] [ HH.text "This is the body of the card!" ]
    --     , Card.body [ P.isFilled false ] [] [ HH.text "This is the body of the card!" ]
    --     , Card.body [ P.isFilled false ] [] [ HH.text "This is the body of the card!" ]
    --     , Card.body [ P.isFilled true ] [] [ HH.text "This is the body of the card!" ]
    --     , Card.footer [] [ HH.text "the footer" ]
    --     ]
    -- ]
    ]

-- Grid.grid
-- [ Grid.hasGutter true ]
-- [ HP.style "height: 100vh" ]
-- [ Grid.gridItem
--   [Grid.span 2
--   , Grid.rowSpan 11]
--   [ ]
--   [ Card.card
--     [P.isFullHeight true ]
--     [ ]
--     [ ]
--   ]
-- , Grid.gridItem
--   [ Grid.span 10
--   , Grid.rowSpan 11]
--   [ ]
--   [ Card.card
--     [ P.isFullHeight true
--     , P.isFlat true
--      ]
--     [ ]
--     [ ]
--   ]
-- , Grid.gridItem
--   [ Grid.span 12
--   , Grid.rowSpan 1]
--   [ ]
--   [ Card.card
--     [P.isFullHeight true ]
--     [ ]
--     [ ]
--   ]
-- ]
