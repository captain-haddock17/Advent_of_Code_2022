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

with Piles_of_Crates;
use Piles_of_Crates;

package Crane is

--   pragma Preelaborate;

   --  =====
   --  Crane
   --  =====
   type Order is record
      Quantity : Natural;
      From, To : Pile_ID_range;
   end record;

   procedure Action (Move : Order; on_Piles : in out Piles_array);

private

end Crane;
