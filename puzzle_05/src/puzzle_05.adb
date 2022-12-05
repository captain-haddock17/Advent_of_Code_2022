pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-05
--  -------------------------------------------------------------
pragma Ada_2022;

with Crates;
use Crates;

with Piles_of_Crates;
use Piles_of_Crates;

with Crane;
use Crane;

with Piles_of_Crates_IO;
use Piles_of_Crates_IO;

with Crane_IO;
use Crane_IO;

with Command_Line;
use Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_05 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File   : File_Type;

   Piles : Piles_array := (others => (Top => null, Current => null));
   Some_Order : Order;
   Result_Part1, Result_Part2 : String (1 .. 9) := (others => ' ');

   --  Part1
   --  Part2

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

   while not End_Of_File (Data_File) loop

      Get_Initial_Piles_of_Crates :
         loop
            declare
               Data : constant String := Get_Line (Data_File);
            begin
               if Data'Length > 0 then
                  if Data (2) in '1' .. '9' then
                     exit Get_Initial_Piles_of_Crates;
                  end if;
                  Read_Top_Down (Data, Piles);
               else
                  exit Get_Initial_Piles_of_Crates;
               end if;
            end;
         end loop Get_Initial_Piles_of_Crates;

      if Run_Args.Trace then -- Trace
         for I in 1 .. Effective_Nb_of_Piles loop
            Put ("Pile #" & I'Image  & " = [");
            Write (Piles (I).Top);
            Put_Line ("]");
         end loop;
      end if;

      Skip_Line (Data_File);

      Get_Crane_Movements :
         while not End_Of_File (Data_File) loop
            declare
               Data : constant String := Get_Line (Data_File);
            begin
               Some_Order := Read_Action (Data);
               Action (Some_Order, Piles);
            end;
         end loop Get_Crane_Movements;
   end loop;
   Close (Data_File);
   New_Line;

   --  Print result of Part 1
   --  ======================
   for I in 1 .. Effective_Nb_of_Piles loop
      if Piles (I).Top /= null then
         Result_Part1 (I) := Piles (I).Top.Crate;
      else
         Result_Part1 (I) := ' ';
      end if;
   end loop;

   --  Print result of Part 1
   --  ======================
   Put ("List of top crates (Part 1) = ");
   Put_Line (Result_Part1 (1 .. Effective_Nb_of_Piles));

   --  Verify if result is as expected
   if Result_Part1 (1 .. Effective_Nb_of_Piles) = "CMZ" then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Result_Part1 (1 .. Effective_Nb_of_Piles)= "BZLVHBWQF" then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   --  Print result of Part 2
   --  ======================
   Put ("List of top crates (Part 2) = ");
   Put_Line (Result_Part2 (1 .. Effective_Nb_of_Piles));

   --  Verify if result is as expected
   if Result_Part2 (1 .. Effective_Nb_of_Piles) = "MCD" then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Result_Part2 (1 .. Effective_Nb_of_Piles)= "BZLVHBWQF" then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_05;
