--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-02
--  -------------------------------------------------------------
pragma Ada_2022;
-- pragma Style_Checks ("M120");

with Rock_Paper_Cissors;
use Rock_Paper_Cissors;

with Rock_Paper_Cissors_IO;
use Rock_Paper_Cissors_IO;

with Command_Line;
use Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;
use Ada;

procedure Puzzle_02 is

   Run_Args    : Command_Line.Program_args;

   ABC_Play, XYZ_Play_Part1, XYZ_Play_Part2 : Rock_Paper_Cissors_Element;
   Total_Score_Part1 : Natural := 0;
   Total_Score_Part2 : Natural := 0;

   function Read_ABC_Play is 
      new Read_Play (Elf_Play_Element,
                     Elf_RPC_Encoding_array,
                     Elf_RPC_encoding,
                     Elf_Play_Data_Position);

   function Read_XYZ_Play_Part1 is 
      new Read_Play (My_Play_Element,
                     My_RPC_Encoding_array,
                     My_RPC_encoding,
                     My_Play_Data_Position);

   function Read_XYZ_Play_Part2 is 
      new Read_Play_Part2 (My_Play_Element,
                           My_Score_Encoding_array,
                           My_Score_encoding,
                           My_Play_Data_Position);

   --  File and Run-Time Parameters
   --  ----------------------------
   Data_File : Ada.Text_IO.File_Type;
   Some_Data : Round_Record;

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

      Some_Data := Get_Line (File => Data_File);
      ABC_Play := Read_ABC_Play (Some_Data);
      XYZ_Play_Part1 := Read_XYZ_Play_Part1 (Some_Data);
      XYZ_Play_Part2 := Rock_Paper_Cissors_Rule (
         Player_ABC => ABC_Play,
         Player_XYZ_Score => Read_XYZ_Play_Part2 (Some_Data));
      Total_Score_Part1 := @ + My_Computed_Score (ABC_Play, XYZ_Play_Part1);
      Total_Score_Part2 := @ + My_Computed_Score (ABC_Play, XYZ_Play_Part2);

   end loop;

   New_Line;

   --  Print result of Part 1
   Put ("My total score  (Part 1) =");
   put_Line (Total_Score_Part1'Image);

   if Total_Score_Part1 = 15 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Score_Part1 = 12156 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   --  Print result of Part 2
   Put ("My total score (Part 2) =");
   put_Line (Total_Score_Part2'Image);

   if Total_Score_Part1 = 12 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Score_Part2 = 10835 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_02;
