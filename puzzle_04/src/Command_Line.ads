pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------

with Ada.Strings.Bounded;

package Command_Line is

   package OS_File_Name is
      new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
   use OS_File_Name;

   type Program_args is record
      Trace          : Boolean := True;
      Data_File_Name : Bounded_String;
   end record;

   BAD_ARGUMENTS : exception;

   Run_Args    : Command_Line.Program_args;

   procedure Get_Args (Args : in out Program_args);

end Command_Line;
