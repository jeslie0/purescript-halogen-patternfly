module Halogen.Patternfly.Table (table, tbody, tr, th, thead, td, caption)where

import Prelude

import DOM.HTML.Indexed as HI
import Data.Array ((:))
import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties (class_, classes)
import Helper (buildOptionsST, PFProp)

classNames =
  { table: ClassName "pf-v5-c-table pf-m-grid-md"
  , tableHead: ClassName "pf-v5-c-table__thead"
  , tableR: ClassName "pf-v5-c-table__tr"
  , tableH: ClassName "pf-v5-c-table__th"
  , tableBody: ClassName "pf-v5-c-table__tbody"
  , tableD: ClassName "pf-v5-c-table__td"
  , compact: ClassName "pf-m-compact"
  , caption: ClassName "pf-v5-c-table__caption"
  }

type TableOptions :: Row Type
type TableOptions =
  ( isCompact :: Boolean
  )

initialTableOptions :: Record TableOptions
initialTableOptions =
  {isCompact: false}

table :: forall w i . Array (PFProp TableOptions) -> HH.Node HI.HTMLtable w i
table options attr =
  let
    fullOptions =
      buildOptionsST options initialTableOptions

    compactClass =
      if fullOptions.isCompact then classNames.compact else ClassName ""
  in
   HH.table $ classes [classNames.table, compactClass] : attr
--

type TableBodyOptions :: Row Type
type TableBodyOptions =
  ()

initialTableBodyOptions :: Record TableBodyOptions
initialTableBodyOptions =
  {}

tbody :: forall w i . Array (PFProp TableBodyOptions) -> HH.Node HI.HTMLtbody w i
tbody options attr =
  let
    fullOptions =
      buildOptionsST options initialTableBodyOptions
  in
   HH.tbody $ class_ classNames.tableBody : attr

--

type TableHeadOptions :: Row Type
type TableHeadOptions =
  ()

initialTableHeadOptions :: Record TableHeadOptions
initialTableHeadOptions =
  {}

thead :: forall w i . Array (PFProp TableHeadOptions) -> HH.Node HI.HTMLthead w i
thead options attr =
  let
    fullOptions =
      buildOptionsST options initialTableHeadOptions
  in
   HH.thead $ class_ classNames.tableHead : attr


--

type TableROptions :: Row Type
type TableROptions =
  ()

initialTableROptions :: Record TableROptions
initialTableROptions =
  {}

tr :: forall w i . Array (PFProp TableROptions) -> HH.Node HI.HTMLtr w i
tr options attr =
  let
    fullOptions =
      buildOptionsST options initialTableROptions
  in
   HH.tr $ class_ classNames.tableR : attr

--

type TableHOptions :: Row Type
type TableHOptions =
  ()

initialTableHOptions :: Record TableHOptions
initialTableHOptions =
  {}

th :: forall w i . Array (PFProp TableHOptions) -> HH.Node HI.HTMLth w i
th options attr =
  let
    fullOptions =
      buildOptionsST options initialTableHOptions
  in
   HH.th $ class_ classNames.tableH : attr
--

type TableDOptions :: Row Type
type TableDOptions =
  ()

initialTableDOptions :: Record TableDOptions
initialTableDOptions =
  {}

td :: forall w i . Array (PFProp TableDOptions) -> HH.Node HI.HTMLtd w i
td options attr =
  let
    fullOptions =
      buildOptionsST options initialTableDOptions
  in
   HH.td $ class_ classNames.tableD : attr

--

type CaptionOptions :: Row Type
type CaptionOptions =
  ()

initialCaptionOptions :: Record TableDOptions
initialCaptionOptions =
  {}

caption :: forall w i . Array (PFProp CaptionOptions) -> HH.Node HI.HTMLcaption w i
caption options attr =
  let
    fullOptions =
      buildOptionsST options initialCaptionOptions
  in
   HH.caption $ class_ classNames.caption : attr
