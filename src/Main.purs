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
import Patternfly.Page as Page
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
  { isSidebarOpen :: Boolean}

initialState :: forall input. input -> Model
initialState _ =
  { isSidebarOpen: true}

-- | UPDATE

data Action =
  ToggleSidebar

handleAction :: forall output m. MonadEffect m => Action -> H.HalogenM Model Action () output m Unit
handleAction action =
  case action of
    ToggleSidebar -> do
      H.modify_ $ \model -> model { isSidebarOpen = not model.isSidebarOpen}

-- | VIEW

render :: forall m. Model -> H.ComponentHTML Action () m
render model =
  Page.page
    [ P.sidebar $ Page.sidebar [ P.isOpen model.isSidebarOpen ] [] [ Page.sidebarBody [] [ HH.text "THis is the sidebar" ] ]
    , P.header $ HH.button [HE.onClick (const ToggleSidebar)] [HH.text "toggle sidebar"]
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
        [ HH.text "HELLO" ]

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
