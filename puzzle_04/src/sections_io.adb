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

package body Sections_IO is

   --  --------------
   --  Read_Record
   --  --------------
   procedure Read_Record (
      Stream : not null access Root_Stream_Type'Class;
      Item   : out Data_Record) is
   begin
      Section_Range'Read (Stream, Item.Elf_1_assignement);

      Character'Read (Stream, Item.Separator);
      --  in case something went wrong in reading the file
      if Item.Separator /= Section_Separator then
         --  null;
         raise BAD_SECTION_SEPARATOR;
      end if;

      Section_Range'Read (Stream, Item.Elf_2_assignement);
   end Read_Record;

   --  --------------
   --  Write_Record
   --  --------------
   procedure Write_Record (   -- for the purpose of tracing
      Stream : not null access Root_Stream_Type'Class;
      Item   : Data_Record) is
   begin
      Section_Range'Write (Stream, Item.Elf_1_assignement);
      Character'Write (Stream, Item.Separator);
      Section_Range'Write (Stream, Item.Elf_2_assignement);
      --  New_Line;
   end Write_Record;

end Sections_IO;
