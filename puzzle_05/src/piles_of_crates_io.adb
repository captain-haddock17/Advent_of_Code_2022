pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-05
--  -------------------------------------------------------------
--  pragma Ada_2022;

with Ada.Text_IO;
use Ada.Text_IO;

package body Piles_of_Crates_IO is

   --  -------------
   --  Read_Top_Down
   --  -------------
   procedure Read_Top_Down (Data : String; Piles : in out Piles_array) is
      Pile_spacing : constant Positive := 4;
      Nb_of_Piles : constant Positive := (Data'Length + 1) / Pile_spacing;
      Pile_Str_Pos : Natural;
      C : Crate_ID;
      Some_Pile : Crate_on_Pile;
   begin
      if Data'Length > 0 then
         for I in 1 .. Nb_of_Piles loop
            Pile_Str_Pos := 1 + (I - 1) * Pile_spacing + 1;
            C := Data (Pile_Str_Pos);
            --  Piles (I).Top := null;
            if C /= ' ' then
               Some_Pile := Insert (Crate => C, Into_Pile => Piles (I).Current);
               if Piles (I).Current = null then
                  Piles (I).Top := Some_Pile;
               end if;
               Piles (I).Current := Some_Pile;
            end if;
         end loop;
         --  update max nb of piles
         if Nb_of_Piles > Effective_Nb_of_Piles then
            Effective_Nb_of_Piles := Nb_of_Piles;
         end if;
      end if;
   end Read_Top_Down;

   --  -----
   --  Write
   --  -----
   procedure Write (Pile : Crate_on_Pile) is
      Pile_Index : Crate_on_Pile := Pile;
   begin
      while Pile_Index /= null loop
         Put (Pile_Index.Crate);
         Pile_Index := Pile_Index.Next;
      end loop;
   end Write;

end Piles_of_Crates_IO;
