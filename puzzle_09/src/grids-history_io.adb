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

package body Grids.History_IO is

   --  ------------------
   --  Tail_History_Write
   --  ------------------
   procedure Tail_History_Write (History : Tail_History)
   is
      subtype X_Dim is X_Dimension 
         range X_Dimension (Show_Grid_range'First) .. X_Dimension (Show_Grid_range'Last);
      subtype Y_Dim is Y_Dimension
         range Y_Dimension (Show_Grid_range'First) .. Y_Dimension (Show_Grid_range'Last);

      type Grid_array is array (X_Dim, Y_Dim) of Character;
      Grid : Grid_array := (others => (others => ' '));
      Start_in_Grid : constant Grid_Position := (0,0);
      Pos_in_Grid : Grid_Position;

   begin
      for E of History loop
         Grid (E.X, E.Y) := '#';
      end loop;

      New_Line;
      for X in Show_Grid_range loop
         put ('_');
      end loop;

      for Y in reverse Y_Dim'Range loop
         for X in X_Dim'Range loop
            Pos_in_Grid := (X, Y);
            if Pos_in_Grid = Start_in_Grid then
               put ('S');
            else
               put (Grid (X, Y));
            end if;
         end loop;
         New_Line;
      end loop;

      for X in Show_Grid_range loop
         put ('_');
      end loop;
      New_Line;
   end Tail_History_Write;

end Grids.History_IO;
