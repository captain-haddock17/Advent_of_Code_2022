pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-06
--  -------------------------------------------------------------
pragma Ada_2022;

with Marker;

with Command_Line; use Command_Line;
with Ada.IO_Exceptions;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

procedure Puzzle_06 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File   : File_Type;
   Data_Stream : Text_Streams.Stream_Access;
   Data        : Character;
   Stream_Index : Natural := 0;

   --  Part 1
   type Packet_Buffer_Index_Type is mod 4;
   package Packet_Marker is new Marker (Packet_Buffer_Index_Type);
   use Packet_Marker;
   Packet_Buffer         : Packet_Marker.Marker_Buffer.Circular_Buffer;
   Packet_Marker_Present : Boolean := False;
   Packet_Starting_at    : Natural := 0;

   --  Part 2
   type Message_Buffer_Index_Type is mod 14;
   package Message_Marker is new Marker (Message_Buffer_Index_Type);
   use Message_Marker;
   Message_Buffer         : Message_Marker.Marker_Buffer.Circular_Buffer;
   Message_Marker_Present : Boolean := False;
   Message_Starting_at    : Natural := 0;

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
   Data_Stream := Text_Streams.Stream (Data_File);

   while not End_Of_File (Data_File) loop
      Character'Read (Data_Stream, Data);
      Stream_Index    := @ + 1;

      --  TODO: Replace this bloc of code ...
      if not Packet_Marker_Present then
         Packet_Buffer.Insert (Data);

         if Run_Args.Trace then -- Trace
            New_Line;
            Put (Stream_Index'Image & ":");
         end if;

         if Marker_Found (Packet_Buffer) then
            Packet_Marker_Present := True;
            Packet_Starting_at := Stream_Index;
         elsif Packet_Buffer.Full then
            Packet_Buffer.Remove;
         end if;
      end if;
      --  TODO: ... by this procedure call:
      --  Packet_Marker.Analyse_Buffer (
      --     Buffer => Packet_Buffer,
      --     Data => Data,
      --     Index => Stream_Index,
      --     Marker_Present => Packet_Marker_Present,
      --     Starting_at => Packet_Starting_at);

      --  TODO: Replace this bloc of code ...
      if not Message_Marker_Present
      then
         Message_Buffer.Insert (Data);

         if Run_Args.Trace
         and then Packet_Marker_Present
         then -- Trace
            New_Line;
            Put (Stream_Index'Image & ":");
         end if;

         if Marker_Found (Message_Buffer) then
            Message_Marker_Present := True;
            Message_Starting_at := Stream_Index;
         elsif Message_Buffer.Full then
            Message_Buffer.Remove;
         end if;
      end if;
      --  TODO: ... by this procedure call:
      --  Message_Marker.Analyse_Buffer (
      --     Buffer => Message_Buffer,
      --     Data => Data,
      --     Index => Stream_Index,
      --     Marker_Present => Message_Marker_Present,
      --     Starting_at => Message_Starting_at);

      if Message_Marker_Present then
         exit;
      end if;

   end loop;
   Close (Data_File);

   --  Part 1
   --  ======

   --  Print result of Part 1
   --  ======================
   New_Line;
   if Packet_Marker_Present then
      Put ("Packet_Starting_at (Part 1) = ");
      Put_Line (Packet_Starting_at'Image);
   else
      Put ("No Packet found (Part 1) = ");
   end if;

   --  Verify if result is as expected
   if Packet_Starting_at = 7 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Packet_Starting_at = 1_816 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

   --  Part 2
   --  ======

   --  Print result of Part 2
   --  ======================
   New_Line;
   if Message_Marker_Present then
      Put ("Message_Starting_at (Part 2) = ");
      Put_Line (Message_Starting_at'Image);
   else
      Put ("No Message found (Part 2) = ");
   end if;

   --  Verify if result is as expected
   if Message_Starting_at = 19 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Message_Starting_at = 2_625 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;
--  ======================
   New_Line;

exception
   when BAD_ARGUMENTS =>
      null; -- exit program
   when ADA.IO_EXCEPTIONS.NAME_ERROR =>
      Put_Line (Standard_Error, "/!\ Input data file NOT found ...");

end Puzzle_06;
