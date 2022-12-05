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

with Cranes;
use Cranes;
   --  Part 1
with Cranes.CrateMover_9000;
   --  Part 2
with Cranes.CrateMover_9001;

with Piles_of_Crates_IO;
use Piles_of_Crates_IO;

with Cranes_IO;
use Cranes_IO;

with Command_Line;
use Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_05 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File   : File_Type;

   Some_Order : Order;

   --  Part 1
   Piles_1 : Piles_array := (others => (Top => null, Current => null));
   Result_Part1 : String (1 .. 9) := (others => ' ');

   --  Part 2
   Piles_2 : Piles_array := (others => (Top => null, Current => null));
   Result_Part2 : String (1 .. 9) := (others => ' ');

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
      --  =======================
         loop
            declare
               Data : constant String := Get_Line (Data_File);
            begin
               if Data'Length > 0 then
                  if Data (2) in '1' .. '9' then
                     exit Get_Initial_Piles_of_Crates;
                  end if;
                  --  Part 1
                  Read_Top_Down (Data, Piles_1);
                  --  Part 2
                  Read_Top_Down (Data, Piles_2);
               else
                  exit Get_Initial_Piles_of_Crates;
               end if;
            end;
         end loop Get_Initial_Piles_of_Crates;

      if Run_Args.Trace then -- Trace
         for I in 1 .. Effective_Nb_of_Piles loop
            Put ("Pile #" & I'Image  & " = [");
            Write (Piles_1 (I).Top);
            Put_Line ("]");
         end loop;
      end if;

      Skip_Line (Data_File);

      Get_and_Do_Cranes_Movements :
      --  =======================
         while not End_Of_File (Data_File) loop
            declare
               Data : constant String := Get_Line (Data_File);
            begin
               Some_Order := Read_Action (Data);
               --  Part 1
               CrateMover_9000.Action (Some_Order, Piles_1);
               --  Part 2
               CrateMover_9001.Action (Some_Order, Piles_2);
            end;
         end loop Get_and_Do_Cranes_Movements;
   end loop;
   Close (Data_File);

   --  Part 1
   --  ======
   for I in 1 .. Effective_Nb_of_Piles loop
      if Piles_1 (I).Top /= null then
         Result_Part1 (I) := Piles_1 (I).Top.Crate;
      else
         Result_Part1 (I) := ' ';
      end if;
   end loop;

   --  Print result of Part 1
   --  ======================
   New_Line;
   Put ("List of top crates (Part 1) = ");
   Put_Line (Result_Part1 (1 .. Effective_Nb_of_Piles));

   --  Verify if result is as expected
   if Result_Part1 (1 .. Effective_Nb_of_Piles) = "CMZ" then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Result_Part1 (1 .. Effective_Nb_of_Piles) = "BZLVHBWQF" then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   --  Part 2
   --  ======
   for I in 1 .. Effective_Nb_of_Piles loop
      if Piles_2 (I).Top /= null then
         Result_Part2 (I) := Piles_2 (I).Top.Crate;
      else
         Result_Part2 (I) := ' ';
      end if;
   end loop;

   --  Print result of Part 2
   --  ======================
   New_Line;
   Put ("List of top crates (Part 2) = ");
   Put_Line (Result_Part2 (1 .. Effective_Nb_of_Piles));

   --  Verify if result is as expected
   if Result_Part2 (1 .. Effective_Nb_of_Piles) = "MCD" then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Result_Part2 (1 .. Effective_Nb_of_Piles) = "TDGJQTZSL" then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   --  ======================
   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_05;
