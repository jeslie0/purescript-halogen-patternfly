module Patternfly.Grid (grid, gridItem) where

import Prelude

import DOM.HTML.Indexed (HTMLdiv)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Properties (buildOptions, PFProp)

classNames =
  { grid: "pf-v5-l-grid"
  , gridGutter: "pf-m-gutter"
  , gridItem: "pf-v5-l-grid__item"
  , col1: "pf-m-1-col"
  , col2: "pf-m-2-col"
  , col3: "pf-m-3-col"
  , col4: "pf-m-4-col"
  , col5: "pf-m-5-col"
  , col6: "pf-m-6-col"
  , col7: "pf-m-7-col"
  , col8: "pf-m-8-col"
  , col9: "pf-m-9-col"
  , col10: "pf-m-10-col"
  , col11: "pf-m-11-col"
  , col12: "pf-m-12-col"
  , row1: "pf-m-1-row"
  , row2: "pf-m-2-row"
  , row3: "pf-m-3-row"
  , row4: "pf-m-4-row"
  , row5: "pf-m-5-row"
  , row6: "pf-m-6-row"
  , row7: "pf-m-7-row"
  , row8: "pf-m-8-row"
  , row9: "pf-m-9-row"
  , row10: "pf-m-10-row"
  , row11: "pf-m-11-row"
  , row12: "pf-m-12-row"
  }


type GridOptions =
  ( hasGutter :: Boolean)

initialGridOptions :: Record GridOptions
initialGridOptions =
  { hasGutter: false
  }


-- hasGutter :: Boolean -> ConfigureGrid
-- hasGutter bool =
--   ConfigureGrid (\op -> op { hasGutter = bool })



makeClassNameFromBool :: String -> Boolean -> H.ClassName
makeClassNameFromBool str bool =
  H.ClassName
  if bool
  then  str
  else ""

grid :: forall w i . Array (PFProp GridOptions) -> HH.Node HTMLdiv w i
grid conf attr  =
  let
    options =
      buildOptions conf initialGridOptions

    gutterClass =
        makeClassNameFromBool classNames.gridGutter options.hasGutter
  in
   HH.div (attr <> [HP.classes [H.ClassName classNames.grid, gutterClass]])

type GridItemOptions =
  ( span :: Maybe Int
  , rowSpan :: Maybe Int)

initialGridItemOptions :: Record GridItemOptions
initialGridItemOptions =
  { span: Nothing
  , rowSpan: Nothing
  }


-- span :: Int -> ConfigureGridItem
-- span n =
--   ConfigureGridItem (\opt -> opt { span = Just n })

-- rowSpan :: Int -> ConfigureGridItem
-- rowSpan n =
--   ConfigureGridItem (\opt -> opt { rowSpan = Just n })


gridItem :: forall i w . Array (PFProp GridItemOptions) -> HH.Node HTMLdiv w i
gridItem conf attr =
  let
    options =
      buildOptions conf initialGridItemOptions

    rowClass =
      H.ClassName <<< getRowClass $ options.rowSpan

    colClass =
      H.ClassName <<< getColClass $ options.span
  in
   HH.div $ attr <> [HP.classes [H.ClassName classNames.gridItem, rowClass, colClass]]

getRowClass :: Maybe Int -> String
getRowClass n =
  case n of
    Just 1 -> classNames.row1
    Just 2 -> classNames.row2
    Just 3 -> classNames.row3
    Just 4 -> classNames.row4
    Just 5 -> classNames.row5
    Just 6 -> classNames.row6
    Just 7 -> classNames.row7
    Just 8 -> classNames.row8
    Just 9 -> classNames.row9
    Just 10 -> classNames.row10
    Just 11 -> classNames.row11
    Just 12 -> classNames.row12
    _ -> ""


getColClass :: Maybe Int -> String
getColClass n =
  case n of
    Just 1 -> classNames.col1
    Just 2 -> classNames.col2
    Just 3 -> classNames.col3
    Just 4 -> classNames.col4
    Just 5 -> classNames.col5
    Just 6 -> classNames.col6
    Just 7 -> classNames.col7
    Just 8 -> classNames.col8
    Just 9 -> classNames.col9
    Just 10 -> classNames.col10
    Just 11 -> classNames.col11
    Just 12 -> classNames.col12
    _ -> ""
