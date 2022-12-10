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

package body Grids.History is

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
   procedure Store_History (TH : in out Tail_History; Rope : Knot_array)
   is
   begin
      for Knot in Knot_ID loop
         if Rope (Knot).ID = Tail_Knot then
            Store_History (TH, Rope (Knot));
         end if;
      end loop;
   end Store_History;

   procedure Store_History (TH : in out Tail_History; Knot : Knot_record)
   is
   begin
         TH.Include (Knot.Pos);
   end Store_History;

end Grids.History;
