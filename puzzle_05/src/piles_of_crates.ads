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

with Crates;
use Crates;

package Piles_of_Crates is
   --  pragma Preelaborate;

   --  =====
   --  Piles
   --  =====
   Max_Piles : constant Positive := 9;
   Effective_Nb_of_Piles : Natural := 0;
   subtype Pile_ID_range is Positive range 1 .. Max_Piles;

   type Pile_record is record
      Top, Current : Crate_on_Pile := null;
   end record;

   type Piles_array is array (Pile_ID_range) of Pile_record;

private

end Piles_of_Crates;
