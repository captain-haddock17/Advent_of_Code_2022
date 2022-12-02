--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-02
--  -------------------------------------------------------------
-- pragma Ada_2022;
-- pragma Style_Checks ("M120");

package Rock_Paper_Cissors is
   pragma Preelaborate;

   --  ====================
   --  Elements of the game
   --  ====================

   type Rock_Paper_Cissors_Element is (Rock, Paper, Cissors);
   for Rock_Paper_Cissors_Element use ( 
      Rock => 1,
      Paper => 2,
      Cissors => 3);
   
   --  ==================
   --  Scores of the game
   --  ==================
   type Score_Kind is (Lost, Draw, Win);
   for Score_Kind use ( 
      Lost => 0,
      Draw => 3,
      Win => 6);

   function My_Computed_Score (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ : Rock_Paper_Cissors_Element)
      return Natural;

   --  =================
   --  Rules of the game
   --  =================
   function Rock_Paper_Cissors_Rule (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ : Rock_Paper_Cissors_Element)
      return Score_Kind;

   function Rock_Paper_Cissors_Rule (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ_Score : Score_Kind)
      return Rock_Paper_Cissors_Element;

private

end Rock_Paper_Cissors;
