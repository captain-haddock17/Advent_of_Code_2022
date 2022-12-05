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

with Piles_of_Crates;
use Piles_of_Crates;

package Piles_of_Crates_IO is

   procedure Read_Top_Down (Data : String; Piles : in out Piles_array);

   procedure Write (Pile : Crate_on_Pile);

end Piles_of_Crates_IO;
