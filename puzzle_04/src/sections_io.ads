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

with Sections;
use Sections;

with Ada.Streams;
use Ada.Streams;

package Sections_IO is

--   pragma Preelaborate;
   Section_Separator : constant Character := ',';
   BAD_SECTION_SEPARATOR : exception;

   type Data_Record is record
      Elf_1_assignement : Section_Range;
      Separator : Character;
      Elf_2_assignement : Section_Range;
   end record;

   procedure Read_Record (
      Stream : not null access Root_Stream_Type'Class;
      Item   : out Data_Record);
   for Data_Record'Read use Read_Record;

   procedure Write_Record (   -- for the purpose of tracing
      Stream : not null access Root_Stream_Type'Class;
      Item   : Data_Record);
   for Data_Record'Write use Write_Record;

private

end Sections_IO;
