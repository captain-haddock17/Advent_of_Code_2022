--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-02
--  -------------------------------------------------------------
pragma Ada_2022;
pragma Style_Checks ("M120");

package body Rock_Paper_Cissors_IO is
 
   --  ===================
   --  Handling of records
   --  ===================

   -- ----------
   --  Read_Play
   -- ----------
   function Read_Play (
      Data : Round_Record) 
      return Rock_Paper_Cissors_Element is

      Element_Char : constant Character := Data (Play_Data_Position);

      -- get the Play_Element value from a Character value
      function Element_Val (C : Character) return Play_Element is
      begin
         return Play_Element'Enum_Val (Character'Pos (C));
      end Element_Val;

   begin
      return RPC_Encoding (Element_Val (Element_Char));
   end Read_Play;

end Rock_Paper_Cissors_IO;
