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

with Ada.Text_IO; use Ada.Text_IO;

package body Tree_Grids_IO is

   --  --------------
   --  Load_Grid_Line
   --  --------------
   procedure Load_Grid_Line (
         Data : String;
         My_Forest : in out Grid;
         NS : NS_Dimension)
   is
   begin
      --  Effective tree positions range from 1 to  Data'Length
      for WE in WE_Dimension'First .. WE_Dimension'First + Data'Length - 1 loop
         My_Forest (NS, WE).Height :=  -- translation to Natural
            Character'Pos (Data (Natural (WE))) - Character'Pos ('0');  
      end loop;
   end Load_Grid_Line;

   -- --------------------
   --  Show_Visible_Trees
   -- --------------------
   procedure Show_Visible_Trees (Forest : Grid) is
   begin
      for NS in NS_Dimension'First .. Effective_NS_Dim loop
         for WE in WE_Dimension'First .. Effective_WE_Dim loop
            if Forest (NS, WE).Is_Visible then
               Put (Natural'Image (Forest (NS, WE).Height));
            else
               Put (" .");
            end if;
         end loop;
         New_Line;
      end loop;
   end Show_Visible_Trees;

end Tree_Grids_IO;
