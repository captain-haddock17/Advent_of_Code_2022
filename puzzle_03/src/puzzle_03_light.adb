pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-03
--  -------------------------------------------------------------
pragma Ada_2022;

with Ada.Containers;
with Ada.Containers.Hashed_Sets;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_03_Light is

   Priority_List : constant String := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
   S : String (1 .. 1); -- as to get an equivalent of «To_String (C : Character)»
   function Hash (Element : Character) return Ada.Containers.Hash_Type is
   begin
      return Character'Pos (Element);
   end Hash;

   package Rucksack is new Ada.Containers.Hashed_Sets (
      Element_Type => Character,
      Hash => Hash,
      Equivalent_Elements => "=",
      "=" =>  "=");
   use Rucksack;

   --  Part1
   Some_Rucksack : array (1 .. 2) of Rucksack.Set;
   Common_Item : Character;
   Priority,
   Total_Priorities_Part1 : Natural := 0;

   --  Part2
   Badge_Item : Character;
   Total_Priorities_Part2 : Natural := 0;

   subtype Group_range is Positive range 1 .. 3;
   Grouped_Rucksack : array (Group_range) of Rucksack.Set
            := (others => Empty_Set);
   Rucksack_Index_in_Group : Positive := Group_range'First;

-- -----
--  Main
-- -----
begin
   while not End_Of_File (Standard_Input) loop
      declare
         Some_Rucksack_Data : constant String := Get_Line (Standard_Input);
         Rucksack_Items_Count : constant Natural := Some_Rucksack_Data'Length;
         --  Part1
         Compartment_Items_Count : Natural;
      begin
         Compartment_Items_Count := Rucksack_Items_Count / 2;
         --  Load an empty rucksack
         Some_Rucksack := (others => Empty_Set);
         for I in 1 .. Compartment_Items_Count loop
            Include (Container => Some_Rucksack (1), New_Item => Some_Rucksack_Data (I));
         end loop;
         for I in Compartment_Items_Count + 1 .. Rucksack_Items_Count loop
            Include (Container => Some_Rucksack (2), New_Item => Some_Rucksack_Data (I));
         end loop;

         --  Find a common item in this rucksack
         Common_Item := Element (Position => First (
            Intersection (Some_Rucksack (1), Some_Rucksack (2))));

         S (1) := Common_Item;
         Priority := Index (Priority_List, S);

         --  Sum-up the priority of that item
         Total_Priorities_Part1 := @ + Priority;

         --  Part2
         Union (
            Target => Grouped_Rucksack (Rucksack_Index_in_Group),
            Source => Some_Rucksack (1));
         Union (
            Target => Grouped_Rucksack (Rucksack_Index_in_Group),
            Source => Some_Rucksack (2));

      exception
         when Constraint_Error =>
            Put_Line (Standard_Error,
               "Total number of items in a rucksack is not even!");
            Put_Line (Standard_Error, "Data: " & Some_Rucksack_Data);
            raise;
      end;

      --  Find a common badge/priority item in grouped rucksacks
      if Rucksack_Index_in_Group = Group_range'Last then

         for i in Group_range'First + 1 .. Group_range'Last loop
            Intersection (
               Grouped_Rucksack (Group_range'First),
               Grouped_Rucksack (i));
         end loop;

         Badge_Item := Element (First (Grouped_Rucksack (Group_range'First)));
         S (1) := Badge_Item;
         Priority := Index (Priority_List, S);

         Total_Priorities_Part2 := @ + Priority;

         Rucksack_Index_in_Group := Group_range'First;
         Grouped_Rucksack := (others => Empty_Set);
      else
         Rucksack_Index_in_Group := @ + 1;
      end if;
   end loop;

   New_Line;

   --  Print result of Part 1
   Put ("Total Priorities  (Part 1) =");
   Put_Line (Total_Priorities_Part1'Image);

   if Total_Priorities_Part1 = 157 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Priorities_Part1 = 8088 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   --  Print result of Part 2
   Put ("Total Priorities (Part 2) =");
   Put_Line (Total_Priorities_Part2'Image);

   if Total_Priorities_Part2 = 70 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Priorities_Part2 = 2522 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

end Puzzle_03_Light;
