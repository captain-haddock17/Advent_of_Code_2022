pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-04
--  -------------------------------------------------------------
pragma Ada_2022;

with Sections;
use Sections;

with Sections_IO;
use Sections_IO;

with Command_Line;
use Command_Line;

with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
use Ada.Text_IO;

procedure Puzzle_04 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File   : File_Type;
   Data_Stream : Text_Streams.Stream_Access;
   Out_Stream  : constant Text_Streams.Stream_Access := Text_Streams.Stream (Standard_Output);
   Data : Data_Record;

   --  Part1
   Total_Inclusive_Sections : Natural := 0;
   --  Part2
   Total_Partly_Inclusive_Sections : Natural := 0;

-- -----
--  Main
-- -----
begin
   --  get the command line arguments
   Command_Line.Get_Args (Args => Run_Args);

   --  Open, read, process the input file
   --  ==================================
   Open
      (File => Data_File,
       Mode => In_File,
       Name => OS_File_Name.To_String (Run_Args.Data_File_Name));
      Data_Stream := Text_Streams.Stream (Data_File);
   Set_Input (Data_File);  -- will be used by 'Sections.Write_Section()'

   while not End_Of_File (Data_File) loop
      Data_Record'Read (Data_Stream, Data);

      if Run_Args.Trace then -- Trace
         Data_Record'Write (Out_Stream, Data);
         Put ("     ");
      end if;

      --  Part 2
      if Is_Partly_Overlapping (
            Data.Elf_1_assignement,
            Data.Elf_2_assignement)
      then
         Total_Partly_Inclusive_Sections := @ + 1;
      end if;

      --  Part 1
      if Is_Fully_Overlapping (
            Data.Elf_1_assignement,
            Data.Elf_2_assignement)
      then
         Total_Inclusive_Sections := @ + 1;
      end if;

      if Run_Args.Trace then -- Trace
         New_Line;
      end if;

   end loop;

   Close (Data_File);
   New_Line;

   --  Print result of Part 1
   --  ======================
   Put ("Total of fully inclusive pairs (Part 1) =");
   Put_Line (Total_Inclusive_Sections'Image);

   --  Verify if result is as expected
   if   Total_Inclusive_Sections = 2 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if   Total_Inclusive_Sections = 567 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   --  Print result of Part 2
   --  ======================
   Put ("Total of partly inclusive pairs (Part 2) =");
   Put_Line (Total_Partly_Inclusive_Sections'Image);

   --  Verify if result is as expected
   if Total_Partly_Inclusive_Sections = 4 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Partly_Inclusive_Sections = 907 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_04;
