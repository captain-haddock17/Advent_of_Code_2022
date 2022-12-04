pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-04
--  -------------------------------------------------------------
--  pragma Ada_2022;

with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Characters.Latin_1;
use Ada.Characters.Latin_1;

with Command_Line;
use Command_Line;

package body Sections is

   --  get the command line arguments
   Run_Args : Command_Line.Program_args;

   --  ------------
   --  Read_Section
   --  ------------
   procedure Read_Section (
      Stream : not null access Root_Stream_Type'Class;
      Item   : out Section_Range) is
   begin
      Get (Item.First);
      Get (Item.Last);
   end Read_Section;

   --  -------------
   --  Write_Section (for the purpose of tracing)
   --  -------------
   procedure Write_Section (
      Stream : not null access Root_Stream_Type'Class;
      Item   : Section_Range) is
   begin
      Put ('[' & Item.First'Image);
      Put (Item.Last'Image & ']');
   end Write_Section;

   --  Part 1
   --  -------------------
   --  Is_Fully_Overlapping
   --  -------------------
   function Is_Fully_Overlapping (Left, Right : Section_Range) return Boolean is
      --  Symetric rule
      function Rule (Left, Right : Section_Range) return Boolean is
      begin
         if (Left.First <= Right.First) and then (-Right.Last <= -Left.Last) then
            return True;
         else
            return False;
         end if;
      end Rule;

   begin
      if Rule (Left, Right)
      or Rule (Right, Left) then
         if Run_Args.Trace then -- Trace
            Put (HT & "Fully");
         end if;
         return True;
      else
         return False;
      end if;
   end Is_Fully_Overlapping;

   --  Part 2
   --  -----------------------
   --  Is_Partly_Overlapping
   --  -----------------------
   function Is_Partly_Overlapping (Left, Right : Section_Range) return Boolean is
      --  Symetric rule
      function Rule (Left, Right : Section_Range) return Boolean is
      begin
         if (Left.First <= Right.First) and then (Right.First <= -Left.Last) then
            return True;
         elsif (-Left.Last <= -Right.Last) and then (Right.First <= -Left.Last) then
            return True;
         else
            return False;
         end if;
      end Rule;

   begin
      if Rule (Left, Right)
      or Rule (Right, Left) then
         if Run_Args.Trace then -- Trace
            Put (HT & "Partly");
         end if;
         return True;
      else
         return False;
      end if;
   end Is_Partly_Overlapping;

end Sections;
