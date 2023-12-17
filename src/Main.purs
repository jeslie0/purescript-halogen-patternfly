module Main where

import Prelude

import Effect (Effect)
import Effect.Class (class MonadEffect)

import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)

import Patternfly.Card as Card
import Patternfly.Grid as Grid

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
  {}

initialState :: forall input. input -> Model
initialState _ = {}

-- | UPDATE

data Action
handleAction :: forall output m . MonadEffect m => Action -> H.HalogenM Model Action () output m Unit
handleAction _ = pure unit

-- | VIEW

render :: forall m. Model -> H.ComponentHTML Action () m
render _ =
  Card.body [P.isFilled true] [] []

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
