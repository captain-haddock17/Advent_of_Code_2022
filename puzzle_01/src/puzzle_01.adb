--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-01
--  -------------------------------------------------------------
pragma Ada_2022;
pragma Style_Checks ("M120");

with Command_Line;
use Command_Line;

with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Bounded;

with Ada.Text_IO;
use Ada.Text_IO;
use Ada;

with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure Puzzle_01 is

   Run_Args    : Command_Line.Program_args;

   subtype Calories is Natural;

   type Elf is record
      Name : Natural;
      Total_Food : Calories;
   end record;

   --  Rank of Elfs, with position 1 = Highest Calories value recorded
   subtype Group_Rank is Positive range 1 .. 3;
   type Group_of_Elfs is array (Group_Rank) of Elf;

   Some_Elf : Elf :=
      (Name => 0, Total_Food => 0);
   Elfs_with_most_Food : Group_of_Elfs :=
      (others => (Name => 0, Total_Food => 0));

   Elf_Index : Natural := 0;
   Some_Food, Total_Calories : Calories := 0;

   --  -----------------------
   --  Elfs_with_Most_Calories
   --  -----------------------
   function Elfs_with_Most_Calories (
      Some_Elf : Elf;
      Top_Elfs : Group_of_Elfs)
      return Group_of_Elfs is

      New_Top_Elfs : Group_of_Elfs := Top_Elfs;
   begin
      for One_of in Group_Rank loop
         if Some_Elf.Total_Food > Top_Elfs (One_of).Total_Food then
            --  first retrograde the other elfs in the group
            for Retrograded in reverse One_of + 1 .. Group_Rank'Last loop
               New_Top_Elfs (Retrograded) := Top_Elfs (Retrograded - 1);
            end loop;
            --  now replace with new value
            New_Top_Elfs (One_of) := Some_Elf;
            exit; -- no need to go further
         end if;
      end loop;

      return New_Top_Elfs;
   end Elfs_with_Most_Calories;

   -- ----------------------------
   --  Compute_Total_Food_of_Group
   -- ----------------------------
   function Compute_Total_Food_of_Group (Top_Elfs : Group_of_Elfs) return Calories is
      Total_Food_of_Group : Calories := 0;
   begin
      for One_of in Group_Rank loop
            Total_Food_of_Group := @ + Top_Elfs (One_of).Total_Food;
            if Run_Args.Trace then -- Trace
               Put ("   " & Top_Elfs (One_of).Name'Image & ":");
               Put_Line (Top_Elfs (One_of).Total_Food'Image);
            end if;
      end loop;
      return Total_Food_of_Group;
   end Compute_Total_Food_of_Group;

   --  File and Run-Time Parameters
   --  ----------------------------
   Data_File : Ada.Text_IO.File_Type;

   package Data_Strings is
      new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 10);
   use Data_Strings;
   Some_Data : Data_Strings.Bounded_String;

   Last_Character_Index : Positive;
   Next_Elf : Boolean := True;

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

   --   Data_Stream := Stream (Data_File);

   while not End_Of_File (Data_File) loop

      Some_Data := Data_Strings.To_Bounded_String (
         Get_Line (File => Data_File));

      if Length (Some_Data) > 0 then -- got some data
         if Next_Elf then
            Elf_Index := @ + 1;
            Some_Elf.Name := Elf_Index;
            Next_Elf := False;
         end if;

         Get (From => Data_Strings.To_String (Some_Data),
              Item => Some_Food,
              Last => Last_Character_Index);

         if Run_Args.Trace then -- Trace
            Put_Line (Elf_Index'Image & ':' & Some_Food'Image);
         end if;
         Some_Elf.Total_Food := @ + Some_Food;
      end if;

      --  next Elf, and compute total of calories of former Elf
      if Length (Some_Data) = 0  or else End_Of_File (Data_File) then
         Next_Elf := True;

         if Run_Args.Trace then -- Trace
            Put ("TOTAL =");
            Put_Line (Some_Elf.Name'Image & ':' & Some_Elf.Total_Food'Image);
         end if;

         Elfs_with_most_Food := Elfs_with_Most_Calories (
            Some_Elf => Some_Elf,
            Top_Elfs => Elfs_with_most_Food);
         Some_Elf.Total_Food := 0;

         if Run_Args.Trace then  -- Trace
            New_Line;
         end if;
      end if;

   end loop;

   New_Line;

   if Elf_Index > 0 then
      --  Print result of Part 1
      Put ("Total Calories of top Elf with most Food =");
      Put_Line (Calories'Image (Elfs_with_most_Food (Group_Rank'First).Total_Food));
      if Elfs_with_most_Food (Group_Rank'First).Total_Food = 24_000 then
         Put_Line ("   Correct answer with test data ;-)");
      end if;

      --  Print result of Part 2
      Total_Calories := Compute_Total_Food_of_Group (Elfs_with_most_Food);

      Put ("Total Calories of first" & Group_Rank'Last'Image & " Elfs with most Food =");
      Put_Line (Calories'Image (Total_Calories));
      if Total_Calories = 45_000 then
         Put_Line ("   Correct answer with test data ;-)");
      end if;
   else
      Put_Line ("No Elfs found in file ?!?!");
   end if;

   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_01;
