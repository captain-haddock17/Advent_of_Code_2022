pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-05
--  -------------------------------------------------------------
pragma Ada_2022;

with Crates;
use Crates;

package body Cranes.CrateMover_9001 is

   --  ------
   --  Action
   --  ------
   procedure Action (Move : Order; on_Piles : in out Piles_array) is
      Some_Crate : Crate_ID := '$';
      Pile_Index, Pile_Next : Crate_on_Pile;
   begin
      for I in 1 .. Move.Quantity loop
         if on_Piles (Move.From).Top /= null then
            on_Piles (Move.From).Top := Pop (Some_Crate, on_Piles (Move.From).Top);
            if I = 1 then
               on_Piles (Move.To).Top := Push (Some_Crate, on_Piles (Move.To).Top);
               Pile_Index := on_Piles (Move.To).Top;
               Pile_Next := on_Piles (Move.To).Top.Next;
            else
               Pile_Index := Insert (Some_Crate, Pile_Index);
               Pile_Index.Next := Pile_Next;
            end if;
         end if;
      end loop;
   end Action;

end Cranes.CrateMover_9001;
