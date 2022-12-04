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

with Ada.Streams;
use Ada.Streams;

package Sections is
   --  pragma Preelaborate;

   --  =======
   --  Section
   --  =======
   subtype Section_ID is Integer range 1 .. 99;
   type Section_Range is record
      First : Section_ID;
      Last  : Section_ID;
   end record;

   type Overlapping is (No, Partly, Fully);

   procedure Read_Section (
      Stream : not null access Root_Stream_Type'Class;
      Item   : out Section_Range);
   for Section_Range'Read use Read_Section;

   procedure Write_Section ( -- for the purpose of tracing
      Stream : not null access Root_Stream_Type'Class;
      Item   : Section_Range);
   for Section_Range'Write use Write_Section;

   --  Part 1
   function Is_Fully_Overlapping (Left, Right : Section_Range) return Boolean;

   --  Part 2
   function Is_Partly_Overlapping (Left, Right : Section_Range) return Boolean;

private

end Sections;
