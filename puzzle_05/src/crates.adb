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

--  with Ada.Unchecked_Deallocation;

package body Crates is

   --  procedure Free is
   --     new Ada.Unchecked_Deallocation (Pile_of_Crates, Crate_on_Pile);

   --  ------
   --  Insert
   --  ------
   function Insert (Crate : Crate_ID;
                    Into_Pile : Crate_on_Pile)
                    return Crate_on_Pile -- current Crate
   is
      Pile : Crate_on_Pile;
   begin
      --  reverse Push
      Pile := new Pile_of_Crates;
      Pile.Crate := Crate;
      Pile.Next := null;
      if Into_Pile /= null then
         Into_Pile.Next := Pile;
      --  Pile.Next := Into_Pile.Next;
      end if;
      return Pile;  -- Top_Crate
   end Insert;

   --  ----
   --  Push
   --  ----
   function Push (Crate : Crate_ID;
                  On_Pile : Crate_on_Pile)
                  return Crate_on_Pile -- Top Crate
   is
      Pile : Crate_on_Pile;
   begin
      Pile := new Pile_of_Crates;
      Pile.Crate := Crate;
      Pile.Next := On_Pile;
      return Pile; -- Top_Crate
   end Push;

   --  ---
   --  Pop
   --  ---
   function Pop (Crate : in out Crate_ID;
                 From_Pile : Crate_on_Pile)
                 return Crate_on_Pile  -- Top Crate
   is
   begin
      Crate := From_Pile.Crate; -- = Top_Crate.Crate
      return From_Pile.Next;
--      Free (From_Pile);
   end Pop;

   --  --------
   --  Is_Empty
   --  --------
   function Is_Empty (Pile : Crate_on_Pile) return Boolean is
   begin
      return Pile = null;
   end Is_Empty;

end Crates;
