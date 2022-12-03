--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-03
--  -------------------------------------------------------------
-- pragma Ada_2022;
-- pragma Style_Checks ("M120");

with Ada.Containers.Hashed_Sets;

package body Rucksacks is

   -- =====
   --  Item
   -- =====

   --  ----
   --  Hash
   --  ----
   function Hash (Element : Item_Type) return Hash_Type is
   begin
      return Item_Type'Pos (Element);
   end Hash;

   --  -----------
   --  Priority_of
   --  -----------
   function Priority_of (Item : Item_Type) return Priority_Range is
   begin
      case Item is
         when 'a' .. 'z' =>
            return Item_Type'Pos (Item) - Item_Type'Pos ('a') + 1;
         when 'A' .. 'Z' =>
            return Item_Type'Pos (Item) - Item_Type'Pos ('A') + 27;
         when others =>
            raise Item_Out_of_Bounds;
      end case;
   end Priority_of;

   -- =========
   --  Rucksack
   -- =========

   --  -----------------
   --  Find_First_Common
   --  -----------------
   function Find_First_Common (Left, Right : Rucksack_Compartment.Set) return Item_Type is
      Common_Set : Rucksack_Compartment.Set;
   begin
      if not (Is_Empty (Left) or Is_Empty (Right)) then
         Common_Set := Intersection (Left, Right);
         return Rucksack_Compartment.Element (Position => First (Common_Set));
      else
         raise Empty_Rucksack_Compartment;
      end if;
   end Find_First_Common;

   --  -----------------
   --  Add
   --  -----------------
   procedure Add (
      Item : Item_Type; 
      Into_Rucksack : in out Rucksack_Compartment.Set ) is
   begin
      Include (Into_Rucksack, Item);
   end;

end Rucksacks;
