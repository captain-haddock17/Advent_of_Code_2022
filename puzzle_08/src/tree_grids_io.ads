pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-08
--  -------------------------------------------------------------
pragma Ada_2022;

with Tree_Grids; use Tree_Grids;

package Tree_Grids_IO is

   procedure Load_Grid_Line (Data : String; My_Forest : in out Grid; NS : NS_Dimension);

   procedure Show_Visible_Trees (Forest : Grid);

private

end Tree_Grids_IO;
