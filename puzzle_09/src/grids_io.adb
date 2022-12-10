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

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body Grids_IO is

   --  -------------------
   --  Grid_Position_Write
   --  -------------------
   procedure Grid_Position_Write (Element : Grid_Position)
   is
   begin
      Put ('(');
      Put (Integer (Element.X),9);
      Put (',');
      Put (Integer (Element.Y),9);
      Put (')');
   end Grid_Position_Write;

end Grids_IO;
