pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-07
--  -------------------------------------------------------------
pragma Ada_2022;

with Filesystems;    use Filesystems;
with Filesystems_IO; use Filesystems_IO;

with Command_Line; use Command_Line;
with Ada.IO_Exceptions;

with Ada.Text_IO; use Ada.Text_IO;

procedure Puzzle_07 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File  : File_Type;

   use Trees;
   File_Tree      : Tree   := Empty_Tree;
   Parent_Dir     : Cursor := No_Element;

   --  Part 1
   Max_Size    : constant Positive := 100_000;
   Total_Part1 : Natural           := 0;

   --  Part 2
   Disk_Space   : constant Positive := 70_000_000;
   Space_Needed : constant Positive := 30_000_000;
   Disk_Used, Space_to_Find    : Natural := 0;
   Total_Part2  : Natural           := 0;

-- -----
--  Main
-- -----
begin
   --  get the command line arguments
   Command_Line.Get_Args (Args => Run_Args);

   --  Open, read, process the input file
   --  ==================================
   Open
     (File => Data_File, Mode => In_File,
      Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

   while not End_Of_File (Data_File) loop
      declare
         Data : constant String := Get_Line (Data_File);
      begin
         Load_Tree (File_Tree, Parent_Dir, Data);
      end;
   end loop;
   Close (Data_File);

   New_Line;

   Save_Size_of_Subtree (File_Tree, Root (File_Tree));

   New_Line;

   --  Part 1
   --  ======
   if Run_Args.Trace or True then -- Trace
      Put_Line ("--  Part 1  --");
      Put_Line ("--------------");
   end if;

   Total_Part1 :=
     Sum_of_Subdirs
       (File_Tree => File_Tree,
        Parent    => File_Tree.Root,
        Max_Size  => Max_Size);

   New_Line;

   --  Part 2
   --  ======
   if Run_Args.Trace or True then -- Trace
      Put_Line ("--  Part 2  --");
      Put_Line ("--------------");
   end if;
   Disk_Used := Size_of_Subtree
       (File_Tree, File_Tree.Root, Disk_Space);

   Space_to_Find := Space_Needed - (Disk_Space - Disk_Used);

   if Run_Args.Trace or True then -- Trace
      Put_Line ("Space_to_Find =" & Space_to_Find'Image);
      New_Line;
   end if;

   Total_Part2 := Size_of_Subtree
       (File_Tree, File_Tree.Root, Space_to_Find);

   --  Print result of Part 1
   --  ======================
   New_Line;
   Put ("Total_Part1 (Part 1) = ");
   Put_Line (Total_Part1'Image);

   --  Verify if result is as expected
   if Total_Part1 = 95_437 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Part1 = 1_243_729
 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   --  Print result of Part 2
   --  ======================
   New_Line;
   Put ("Total_Part2 (Part 2) = ");
   Put_Line (Total_Part2'Image);

   --  Verify if result is as expected
   if Total_Part2 = 94_853 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Part2 = 4_443_914
 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;
--  ======================
   New_Line;

exception
   when BAD_ARGUMENTS =>
      null; -- exit program
   when Ada.IO_Exceptions.Name_Error =>
      Put_Line (Standard_Error, "/!\ Input data file NOT found ...");

end Puzzle_07;
