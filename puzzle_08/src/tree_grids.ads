pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-08
--  -------------------------------------------------------------
pragma Ada_2022;

package Tree_Grids is

   subtype Height_range is natural range 0 .. 9;
   type Tree is record
      Height     : Height_range;
      Is_Visible : Boolean := False;
   end record;

   subtype Grid_Distance is Natural;
   subtype Grid_Dimension is Natural range 1 .. 100;

   type NS_Dimension is new Grid_Dimension;
   type WE_Dimension is new Grid_Dimension;

   type Grid is array (NS_Dimension'Range, WE_Dimension'Range) of Tree;

   type Position is record 
      NS : NS_Dimension; 
      WE : WE_Dimension;
   end record;

   type Point_of_Vue is (North, South, East, West);

   --  Global variables
   --  FixMe: Could be implemented with get()/set() function/procedure
   Effective_NS_Dim : NS_Dimension := NS_Dimension'First;
   Effective_WE_Dim : WE_Dimension := WE_Dimension'First;

   procedure Set_Trees_to_Invisible (Forest : in out Grid);

   procedure Check_Visible_Trees (Forest : in out Grid);

   function Count_Visible_Trees (Forest : Grid) return Natural;

   function Find_Best_Scenic_View (Forest : Grid) return Grid_Distance;

private

end Tree_Grids;
