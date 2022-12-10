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

package Grids is

   subtype Grid_Dimension is Integer;
   Max_Grid_Dimension : constant Grid_Dimension := 2 ** 15;
   --  = 2 ** (Hash_Type'Size / 2 - 1)
   --  => 32.000 items max
   subtype Show_Grid_range is Grid_Dimension range -12 .. 15;

   type X_Dimension is new Grid_Dimension
      range -Max_Grid_Dimension .. Max_Grid_Dimension;
   type Y_Dimension is new Grid_Dimension
      range -Max_Grid_Dimension .. Max_Grid_Dimension;

   type Grid_Position is record 
      X : X_Dimension;
      Y : Y_Dimension; 
   end record;

   --  Global variables
   --  FixMe: Could be implemented with get()/set() function/procedure
   Start_Pos : Grid_Position := (0, 0);

private

end Grids;
