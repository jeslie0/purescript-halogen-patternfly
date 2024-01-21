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
  , caption: ClassName "pf-v5-c-table__caption"
  , compact: ClassName "pf-m-compact"
  , noBorderRows: ClassName "pf-m-no-border-rows"
  , center: ClassName "pf-m-center"
  }

type TableOptions :: Row Type
type TableOptions =
  ( isCompact :: Boolean
  , hasBorderRows :: Boolean
  )

initialTableOptions :: Record TableOptions
initialTableOptions =
  { isCompact: false
  , hasBorderRows: true
  }


table :: forall w i . Array (PFProp TableOptions) -> HH.Node HI.HTMLtable w i
table options attr =
  let
    fullOptions =
      buildOptionsST options initialTableOptions

    compactClass =
      if fullOptions.isCompact then classNames.compact else ClassName ""

    borderRowsClass =
      if fullOptions.hasBorderRows then ClassName "" else classNames.noBorderRows
  in
   HH.table $ classes [classNames.table, compactClass, borderRowsClass] : attr
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
  ( isTextCentered :: Boolean )

initialTableHOptions :: Record TableHOptions
initialTableHOptions =
  { isTextCentered: false }

th :: forall w i . Array (PFProp TableHOptions) -> HH.Node HI.HTMLth w i
th options attr =
  let
    fullOptions =
      buildOptionsST options initialTableHOptions

    textCenteredClass =
      if fullOptions.isTextCentered then classNames.center else ClassName ""
  in
   HH.th $ classes [classNames.tableH, textCenteredClass] : attr
--

type TableDOptions :: Row Type
type TableDOptions =
  ( isTextCentered :: Boolean )

initialTableDOptions :: Record TableDOptions
initialTableDOptions =
  { isTextCentered: false }

td :: forall w i . Array (PFProp TableDOptions) -> HH.Node HI.HTMLtd w i
td options attr =
  let
    fullOptions =
      buildOptionsST options initialTableDOptions

    textCenteredClass =
      if fullOptions.isTextCentered then classNames.center else ClassName ""
  in
   HH.td $ classes [classNames.tableD, textCenteredClass] : attr

--

type CaptionOptions :: Row Type
type CaptionOptions =
  ()

initialCaptionOptions :: Record CaptionOptions
initialCaptionOptions =
  {}

caption :: forall w i . Array (PFProp CaptionOptions) -> HH.Node HI.HTMLcaption w i
caption options attr =
  let
    fullOptions =
      buildOptionsST options initialCaptionOptions
  in
   HH.caption $ class_ classNames.caption : attr
