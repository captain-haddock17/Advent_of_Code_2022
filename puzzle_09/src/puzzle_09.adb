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

with Ropes;          use Ropes;
with Ropes.Moves;    use Ropes.Moves;
with Ropes.Moves_IO; use Ropes.Moves_IO;
with Grids;             use Grids;
with Grids_IO;          use Grids_IO;
with Grids.History;     use Grids.History;
with Grids.History_IO;  use Grids.History_IO;
--  with Moves_IO; use Moves_IO;

with Command_Line; use Command_Line;
with Ada.IO_Exceptions;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
With Ada.Characters.Latin_1; use Ada.Characters;


procedure Puzzle_09 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File  : File_Type;
   Data_Stream : Text_Streams.Stream_Access;
   Some_Displacement : Displacement;

   --  Data
   use Tail_History_Sets;

   Reset_Rope : constant Knots_array :=
      (for K_ID in Knot_ID => (ID => K_ID, Pos => Start_Pos));
   Rope, Previous_Rope : Knots_array := Reset_Rope;

   TH : Tail_History := Empty_Set;

   --  Part 1
   Total_Tail1_Positions : Natural := 0;

   --  Part 2
   Total_Tail9_Positions : Natural := 0;

   --  --------------
   --  Trace «Aspect»
   --  --------------
   type Trace_JoinPoint is (Show_Input, Show_Positions, Show_Grid);
   Trace_PointCuts : array (Trace_JoinPoint) of Boolean;  -- at disposal for use
   procedure Trace_Advice (CrossPoint : Trace_JoinPoint) is
   begin
      if Run_Args.Trace then -- Trace
         case CrossPoint is
            when Show_Input =>
               Displacement_Write (Some_Displacement);
            when Show_Positions =>
               Put (Latin_1.HT);
               Grid_Position_Write (Rope (Head_Knot).Pos);
               Grid_Position_Write (Rope (Tail_Knot).Pos);
               New_Line;
            when Show_Grid =>
               Tail_History_Write (TH);
         end case;
      end if;
   end Trace_Advice;

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

   Set_Input (Data_File);  -- will be used by 'Sections.Write_Section()'
   Data_Stream := Text_Streams.Stream (Data_File);

   --  Part 1
   --  ======
   Trace_Advice (Show_Positions); -- Trace

   Store_History (Th, Rope);

   while not End_Of_File (Data_File) loop
      Displacement'Read (Data_Stream, Some_Displacement);
      Trace_Advice (Show_Input);

      Previous_Rope (Head_Knot).Pos := Rope (Head_Knot).Pos;

      Rope (Head_Knot).Pos := New_Head_Position (Rope (Head_Knot).Pos, Some_Displacement);

      Rope (Tail_Knot).Pos := New_Tail_Position (
         Tail_Pos   => Rope (Tail_Knot).Pos,
         Head_From  => Previous_Rope (Head_Knot).Pos,
         Move       => Some_Displacement,
         History    => TH);

      Trace_Advice (Show_Positions); -- Trace
   end loop;

   Trace_Advice (Show_Grid); -- Trace
   Total_Tail1_Positions := Natural (Length (TH));

   --  Part 2
   --  ======
   Reset (Data_File);
   Rope := Reset_Rope;
   Previous_Rope := Reset_Rope;
   Clear (TH);  -- = Empty_Set

   Store_History (Th, Rope);

   while not End_Of_File (Data_File) loop
      Displacement'Read (Data_Stream, Some_Displacement);
      Trace_Advice (Show_Input);

      Previous_Rope (Head_Knot).Pos := Rope (Head_Knot).Pos;

      Rope (Head_Knot).Pos := New_Head_Position (Rope (Head_Knot).Pos, Some_Displacement);

      Rope := New_Rope_Position (
            This_Rope => Rope,
            Previous  => Previous_Rope,
            Move      => Some_Displacement,
            History   => TH);

      Trace_Advice (Show_Positions); -- Trace
   end loop;
   Close (Data_File);

   Trace_Advice (Show_Grid); -- Trace
   Total_Tail9_Positions := Natural (Length (TH));

   --  Print result of Part 1
   --  ======================
   New_Line;
   Put ("Total_Tail1_Positions (Part 1) = ");
   Put_Line (Total_Tail1_Positions'Image);

   --  Verify if result is as expected
   if Total_Tail1_Positions = 13 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Tail1_Positions = 5735
 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   --  Print result of Part 2
   --  ======================
   New_Line;
   Put ("Total_Tail9_Positions (Part 2) = ");
   Put_Line (Total_Tail9_Positions'Image);

   --  Verify if result is as expected
   if Total_Tail9_Positions = 36 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Total_Tail9_Positions = 1
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

end Puzzle_09;
