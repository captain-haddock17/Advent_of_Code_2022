pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-08
--  -------------------------------------------------------------
pragma Ada_2022;

with Tree_Grids;    use Tree_Grids;
with Tree_Grids_IO; use Tree_Grids_IO;

with Command_Line; use Command_Line;
with Ada.IO_Exceptions;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Puzzle_08 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File  : File_Type;

   --  Data
   My_Forest : Grid := (others => ( 
                           others => (Height => 0, Is_Visible => True)));
   NS_Dim : Natural := 0;
   WE_Dim : Natural := 0;

   --  Part 1
   Total_Visible_Trees : Natural := 0;

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
      --  Effective tree NS positions range from 1 to Data'Length
      declare
         Data : constant String := Get_Line (Data_File);
      begin
         if Data'Length > 1 then 
            NS_Dim := @ + 1;
            WE_Dim := Natural'Max (WE_Dim, Data'Length);
            Load_Grid_Line (Data, My_Forest, NS_Dimension (NS_Dim));
         end if;
      end;
   end loop;
   Close (Data_File);

   Effective_NS_Dim := NS_Dimension (NS_Dim); --  Border of grid goes up to (Nb of lines)
   Effective_WE_Dim := WE_Dimension (WE_Dim); --  Border of grid goes up to (Data'Length)

   if Run_Args.Trace then -- Trace
      Put ("Forest dimensions (NS =");
      Put (Natural (Effective_NS_Dim), 4);
      Put (")(WE =");
      Put (Natural (Effective_WE_Dim), 4);
      Put_Line (")");
      New_Line;
      Show_Visible_Trees (My_Forest);
   end if;

   --  Part 1
   --  ======   
   Set_Trees_to_Invisible (My_Forest);
   Check_Visible_Trees (My_Forest);

   if Run_Args.Trace then -- Trace
      Put_Line ("--  Part 1  --");
      Put_Line ("--------------");
      Show_Visible_Trees (My_Forest);
   end if;

   Total_Visible_Trees := Count_Visible_Trees (Forest => My_Forest);

   --  Print result of Part 1
   --  ======================
   New_Line;
   Put ("Total_Visible_Trees (Part 1) = ");
   Put_Line (Total_Visible_Trees'Image);

   --  Verify if result is as expected
   if Total_Visible_Trees = 21 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Visible_Trees = 1776
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

end Puzzle_08;
