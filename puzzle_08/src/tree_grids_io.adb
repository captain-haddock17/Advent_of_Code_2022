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

with Command_Line; use Command_Line;

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Tree_Grids_IO is

   --  --------------
   --  Load_Grid_Line
   --  --------------
   procedure Load_Grid_Line (Data : String; My_Forest : in out Grid; NS : NS_Dimension)
   is
   begin
      --  Effective tree positions range from 1 to  Data'Length
      --  Border of grid is 0 and  Data'Length + 1; value (already) set to 0
      for WE in WE_Dimension'First + 1 .. WE_Dimension'First + Data'Length loop
         My_Forest (NS, WE).Height := Character'Pos (Data (Natural (WE))) - Character'Pos ('0');  -- translation to Natural
      end loop;
   end Load_Grid_Line;

   -- --------------------
   --  Show_Visible_Trees
   -- --------------------
   procedure Show_Visible_Trees (Forest : Grid) is
--      Visible : Boolean;
--     Tree_Position : Position;
   begin
      for NS in NS_Dimension'First + 1 .. Effective_NS_Dim - 1 loop
         for WE in WE_Dimension'First + 1 .. Effective_WE_Dim - 1 loop
            if Forest (NS, WE).Is_Visible then
               Put (Natural'Image (Forest (NS, WE).Height));
            else
               Put (" .");
            end if;
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Show_Visible_Trees;

end Tree_Grids_IO;
