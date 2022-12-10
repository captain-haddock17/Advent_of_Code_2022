pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-09
--  -------------------------------------------------------------
pragma Ada_2022;

with Ada.Containers;
use Ada.Containers;
with Ada.Containers.Hashed_Sets;

package Grids.History is

   function Hash_Position (Element : Grid_Position) return Hash_Type;

   function "=" (Left, Right : Grid_Position) return Boolean;

   package Tail_History_Sets is new Ada.Containers.Hashed_Sets (
      Element_Type => Grid_Position,
      Hash => Hash_Position,
      Equivalent_Elements => "=",
      "="  => "=");
   subtype Tail_History is Tail_History_Sets.Set;

   procedure Store_History (TH : in out Tail_History; Pos : Grid_Position);

private

end Grids.History;
