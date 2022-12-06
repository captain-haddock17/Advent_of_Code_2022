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

with Start_of_Packet_Marker; use Start_of_Packet_Marker;

with Command_Line; use Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

procedure Puzzle_06 is

   --  File and Run-Time Parameters
   --  ============================
   Data_File   : File_Type;
   Data_Stream : Text_Streams.Stream_Access;
   Data        : Character;

   --  Part 1
   Start_of_Packet : Natural := 0;
   Start_of_Packet_Marker_Present  : Boolean := False;

   Data_Start_of_Packet_Marker_Buffer : Start_of_Packet_Marker_Buffer.Circular_Buffer;
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
      Start_of_Packet := @ + 1;

      Data_Start_of_Packet_Marker_Buffer.Insert (Data);

      if Start_of_Packet_Marker_Found (Data_Start_of_Packet_Marker_Buffer) then
         Start_of_Packet_Marker_Present := True;
         exit;
      end if;

      if Data_Start_of_Packet_Marker_Buffer.Full then
         Data_Start_of_Packet_Marker_Buffer.Remove;
      end if;


   end loop;
   Close (Data_File);

   --  Part 1
   --  ======

   --  Print result of Part 1
   --  ======================
   New_Line;
   if Start_of_Packet_Marker_Present then
      Put ("Start_of_Packet (Part 1) = ");
      Put_Line (Start_of_Packet'Image);
   else
      Put ("No Packet found (Part 1) = ");
   end if;

   --  Verify if result is as expected
   if Start_of_Packet = 7 then
      Put_Line ("   Correct answer with test data ;-)");
   end if;
   if Start_of_Packet = 1816 then
      Put_Line ("   Correct answer with input data ;-)");
   end if;

--  ======================
   New_Line;

exception
   when BAD_ARGUMENTS =>
      null; -- exit program

end Puzzle_06;
