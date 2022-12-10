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

package Grids is

   subtype Grid_Dimension is Integer;
   Max_Grid_Dimension : constant Grid_Dimension := 2 ** 15;
   --  = 2 ** (Hash_Type'Size / 2 - 1)
   --  => 32.000 items max
   subtype Show_Grid_range is Grid_Dimension range -12 .. 15;

   type X_Dimension is new Grid_Dimension range -Max_Grid_Dimension .. Max_Grid_Dimension;
   type Y_Dimension is new Grid_Dimension range -Max_Grid_Dimension .. Max_Grid_Dimension;

   type Grid_Position is record 
      X : X_Dimension;
      Y : Y_Dimension; 
   end record;

   procedure Position_Write (Element : Grid_Position);

   function Hash_Position (Element : Grid_Position) return Hash_Type;

   function "=" (Left, Right : Grid_Position) return Boolean;

   package Tail_History_Sets is new Ada.Containers.Hashed_Sets (
      Element_Type => Grid_Position,
      Hash => Hash_Position,
      Equivalent_Elements => "=",
      "="  => "=");
   subtype Tail_History is Tail_History_Sets.Set;

   --  Global variables
   --  FixMe: Could be implemented with get()/set() function/procedure
   Actual_Pos : Grid_Position := (0, 0);

   procedure Store_History (TH : in out Tail_History; Pos : Grid_Position);

   procedure Grid_Write (Histroy : Tail_History);


private

end Grids;
