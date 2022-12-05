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

package Crates is
   --  pragma Preelaborate;

   --  ======
   --  Crates
   --  ======
   subtype Crate_ID is Character;

   --  ==============
   --  Pile of Crates
   --  ==============
   type Pile_of_Crates;
   type Crate_on_Pile is access all Pile_of_Crates;
   type Pile_of_Crates is record
      Crate : Crate_ID;
      Next : Crate_on_Pile := null;
   end record;

   function Insert (Crate : Crate_ID;
                    Into_Pile : in out Crate_on_Pile)
                    return Crate_on_Pile; -- Top Crate

   function Push (Crate : Crate_ID;
                  On_Pile : Crate_on_Pile)
                  return Crate_on_Pile; -- Top Crate

   function Pop (Crate : in out Crate_ID;
                 From_Pile : Crate_on_Pile)
                 return Crate_on_Pile  -- Top Crate
   with Pre => From_Pile /= null;

   function Is_Empty (Pile : Crate_on_Pile) return Boolean;

private

end Crates;
