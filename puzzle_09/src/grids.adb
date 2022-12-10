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

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body Grids is

   --  -------------
   --  Hash_Position
   --  -------------
   function Hash_Position (Element : Grid_Position) return Ada.Containers.Hash_Type
   is
      I, J : Natural;
      
   begin
      I := Natural (Element.X - X_Dimension'First);
      J := Natural ((Element.Y - Y_Dimension'First)) * Max_Grid_Dimension;
      return Hash_Type (J + I);
   end Hash_Position;

   --  -------------
   --  "="
   --  -------------
   function "=" (Left, Right : Grid_Position) return Boolean
   is
   begin
      return Left.X = Right.X and then Left.Y = Right.Y;
   end "=";

   --  -------------
   --  Store_History
   --  -------------
   procedure Store_History (TH : in out Tail_History; Pos : Grid_Position)
   is
   begin
      TH.Include (Pos);
   end Store_History;

   --  -------------
   --  Hash_Position
   --  -------------
   procedure Position_Write (Element : Grid_Position)
   is
   begin
      Put ('(');
      Put (Integer (Element.X),9);
      Put (',');
      Put (Integer (Element.Y),9);
      Put (')');
   end Position_Write;


   --  ----------
   --  Grid_Write
   --  ----------
   procedure Grid_Write (Histroy : Tail_History)
   is
      subtype Grid_range is Grid_Dimension range 0 .. 5;
      type Grid_array is array (Grid_range, Grid_range) of Character;
      Grid_Pos : Grid_range := 0;
      Grid : Grid_array := (others => (others => ' '));

   begin
      for E of Histroy loop
         Grid (E.X, E.Y) := '#';
      end loop;

      New_Line;
      for X in Grid_range loop
         put ('_');
      end loop;

      for Y in reverse Grid_range loop
         for X in Grid_range loop
            if X = 0
            and then Y = 0
            then 
               put ('S');
            else
               put (Grid (X, Y));
            end if;
         end loop;
         New_Line;
      end loop;

      for X in Grid_range loop
         put ('_');
      end loop;
      New_Line;
   end Grid_Write;


end Grids;
