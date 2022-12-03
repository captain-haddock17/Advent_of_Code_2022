--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-03
--  -------------------------------------------------------------
pragma Ada_2022;
-- pragma Style_Checks ("M120");

with Rucksacks;
use Rucksacks;

with Command_Line;
use Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;
use Ada;

procedure Puzzle_03 is

   Run_Args    : Command_Line.Program_args;

   Total_Priorities_Part1 : Natural := 0;

   --  File and Run-Time Parameters
   --  ----------------------------
   Data_File : Ada.Text_IO.File_Type;

   --  Part1
   Some_Rucksack : Rucksack 
      := (others => Rucksack_Compartment.Empty_Set);
   Common_Item : Item_Type;

   --  Part2
   Priority,
   Total_Priorities_Part2 
      : Natural := 0;
   Grouped_Rucksack : Grouped_Rucksack_array 
      := (others => Rucksack_Compartment.Empty_Set);
   Rucksack_Index_in_Group : Positive := 1;

-- -----
--  Main
-- -----
begin
   --  get the command line arguments
   Command_Line.Get_Args (Args => Run_Args);

   --  Open and read the file
   Open
      (File => Data_File,
       Mode => In_File,
       Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

   while not End_Of_File (Data_File) loop
      declare
         Some_Rucksack_Data : constant String := Get_Line (File => Data_File);
         Rucksack_Items_Count : constant Natural := Some_Rucksack_Data'Length;
         --  Part1
         Compartment_Items_Count : Natural;
      begin
          Compartment_items_Count := Rucksack_Items_Count / 2;
          -- Load an empty rucksack
         Some_Rucksack := (others => Rucksack_Compartment.Empty_Set);
          for I in 1 .. Compartment_Items_Count loop
            Add (Into_Rucksack => Some_Rucksack (1), Item => Some_Rucksack_Data (I));
         end loop;
          for I in Compartment_Items_Count + 1 .. Rucksack_Items_Count loop
            Add (Into_Rucksack => Some_Rucksack (2), Item => Some_Rucksack_Data (I));
         end loop;

          -- Find a common item in this rucksack
         Common_Item := Find_First_Common (Some_Rucksack (1), Some_Rucksack (2));

          -- Sum-up the priority of that item
          Total_Priorities_Part1 := @ + Priority_of (Common_Item);

         --  Part2
         Rucksack_Compartment.Union (
            Target => Grouped_Rucksack (Rucksack_Index_in_Group), 
            Source => Some_Rucksack (1));
         Rucksack_Compartment.Union (
            Target => Grouped_Rucksack (Rucksack_Index_in_Group), 
            Source => Some_Rucksack (2));

      exception
         when Constraint_Error =>
            Text_IO.Put (Standard_Error, 
               "Total number of items in a rucksack is not even!");
      end;

      if Rucksack_Index_in_Group = 3 then
         Common_Item := Find_First_Common (Grouped_Rucksack (1), 
            Rucksack_Compartment.Intersection (
               Grouped_Rucksack (2), 
               Grouped_Rucksack (3)));

         Priority := Priority_of (Common_Item);
         if Run_Args.Trace then -- Trace
            Put_Line ("   Priority (" & Common_Item & ") =" & Priority'Image);
         end if;

         Total_Priorities_Part2 := @ + Priority;

         Rucksack_Index_in_Group := 1;
         Grouped_Rucksack := (others => Rucksack_Compartment.Empty_Set);
      else
         Rucksack_Index_in_Group := @ + 1;
      end if;
   end loop;

   New_Line;

   --  Print result of Part 1
   Put ("Total Priorities  (Part 1) =");
   put_Line (Total_Priorities_Part1'Image);

   if Total_Priorities_Part1 = 157 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Priorities_Part1 = 8088 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   --  Print result of Part 2
   Put ("Total Priorities (Part 2) =");
   put_Line (Total_Priorities_Part2'Image);

   if Total_Priorities_Part2 = 70 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Priorities_Part2 = 2522 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_03;
