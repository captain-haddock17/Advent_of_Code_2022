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

with Ada.Strings.Maps; use Ada.Strings.Maps;

with Ada.Text_IO; use Ada.Text_IO;

with Command_Line; use Command_Line;

package body Marker is

   --  --------------
   --  Analyse_Buffer
   --  --------------
   procedure Analyse_Buffer (
         Buffer : in out Marker_Buffer.Circular_Buffer;
         Data   : Character;
         Index : Natural;
         Marker_Present : in out Boolean;
         Starting_at : in out Natural) is
   begin
      if not Marker_Present then
         Buffer.Insert (Data);

         if Run_Args.Trace then -- Trace
            New_Line;
            Put (Index'Image & ":");
         end if;

         if Marker_Found (Buffer) then
            Marker_Present := True;
            Starting_at := Index;
         elsif Buffer.Full then
            Buffer.Remove;
         end if;
      end if;
   end Analyse_Buffer;

   --  ------------
   --  Marker_Found
   --  ------------
   function Marker_Found
     (Buffer : Marker_Buffer.Circular_Buffer) return Boolean
   is
      C             : Character;
      Data_Sequence : Character_Sequence (1 .. Marker_Length) :=
        (others => ' ');
      Data_Set : Character_Set;
   begin
      while Buffer.Count = Marker_Length loop

         Get_Data_from_Buffer :
         --  ----------------
         for I in Marker_Index loop
            Data_Sequence (Integer (I) + 1) := Buffer.Read (I);
         end loop Get_Data_from_Buffer;

         if Run_Args.Trace then -- Trace
            Put (Data_Sequence);
         end if;

         Find_Duplicate :
         --  ----------
         for I in 1 .. Marker_Length - 1 loop
            C        := Data_Sequence (I);
            Data_Set := To_Set (Data_Sequence (I + 1 .. Marker_Length));
            if Is_In (C, Data_Set) then
               return False;
            end if;
         end loop Find_Duplicate;

         return True;

      end loop;
      return False;
   end Marker_Found;

end Marker;
