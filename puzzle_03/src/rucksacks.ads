pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-03
--  -------------------------------------------------------------
--  pragma Ada_2022;

with Ada.Containers;
use Ada.Containers;

with Ada.Containers.Hashed_Sets;

package Rucksacks is
   pragma Preelaborate;

   --  ====
   --  Item
   --  ====
   subtype Item_Type is Character range 'A' .. 'z';
   subtype Priority_Range is Integer range 1 .. 52;
   Item_Out_of_Bounds : exception;

   function Hash (Element : Item_Type) return Hash_Type;

   function Priority_of (Item : Item_Type) return Priority_Range;

   --  ========
   --  Rucksack
   --  ========
   --  package Rucksack_Compartment is new Ada.Containers.Hashed_Sets (
   --     Element_Type => Item_Type,
   --     Hash => with function Hash (Element : Element_Type) return Hash_Type
   --     Equivalent_Elements => with function Equivalent_Elements
   --               (Left, Right : Element_Type) return Boolean;
   --     "=" => with function "=" (Left, Right : Element_Type) return Boolean is <>;))

   package Rucksack_Compartment is new Ada.Containers.Hashed_Sets (
      Element_Type => Item_Type,
      Hash => Hash,
      Equivalent_Elements => "=",
      "=" =>  "=");

   use Rucksack_Compartment;

   type Rucksack is array (Positive range 1 .. 2) of Rucksack_Compartment.Set;
   Empty_Rucksack_Compartment : exception;
   No_Common_Badge : exception;

   function Find_First_Common (Left, Right : Rucksack_Compartment.Set)
      return Item_Type;

   function Find_First_Common (Set : Rucksack_Compartment.Set)
      return Item_Type;

   procedure Add (
      Item : Item_Type;
      Into_Rucksack : in out Rucksack_Compartment.Set);

   --  Part 2
   subtype Group_range is Positive range 1 .. 3;
   type Grouped_Rucksack_array is
      array (Group_range)
         of Rucksack_Compartment.Set;

private

end Rucksacks;
