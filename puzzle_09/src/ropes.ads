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

with Grids; use Grids;

package Ropes is

   Head_Knot : constant Integer := 0;
   Tail_Knot : constant Integer := 9;
   subtype Knot_ID is Integer range Head_Knot .. Tail_Knot;

   type Knot_record is record
      ID : Knot_ID;
      Pos : Grid_Position;
   end record;
   type Knots_array is array (Knot_ID'Range) of Knot_record;

private

end Ropes;
