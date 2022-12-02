--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-02
--  -------------------------------------------------------------
pragma Ada_2022;
-- pragma Style_Checks ("M120");

package body Rock_Paper_Cissors is
   --  ==================
   --  Scores of the game
   --  ==================
   --  add value of Element + value of the outcome

   --  ------------------
   --  My_Computed_Score
   --  ------------------
   function My_Computed_Score (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ : Rock_Paper_Cissors_Element)
      return Natural is
   begin
      return Rock_Paper_Cissors_Element'Enum_Rep (Player_XYZ)
         + Score_Kind'Enum_Rep (
            Rock_Paper_Cissors_Rule (Player_ABC, Player_XYZ));
   end My_Computed_Score;

   --  =================
   --  Rules of the game
   --  =================
   --  Rock defeats Scissors, 
   --  Scissors defeats Paper,
   --  Paper defeats Rock.

   --  -----------------------
   --  Rock_Paper_Cissors_Rule
   --  -----------------------
   function Rock_Paper_Cissors_Rule (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ : Rock_Paper_Cissors_Element)
      return Score_Kind is
   begin
      if Player_ABC = Player_XYZ then
         return Draw;
      end if;
      case Player_ABC is
         when Rock =>
            case Player_XYZ is
               when Paper => return Win;
               when Cissors => return Lost;
               when others => return Draw;
            end case;
         when Paper =>
            case Player_XYZ is
               when Rock => return Lost;
               when Cissors => return Win;
               when others => return Draw;
            end case;
         when Cissors =>
            case Player_XYZ is
               when Rock => return Win;
               when Paper => return Lost;
               when others => return Draw;
            end case;
      end case;
   end Rock_Paper_Cissors_Rule;

   function Rock_Paper_Cissors_Rule (
      Player_ABC : Rock_Paper_Cissors_Element;
      Player_XYZ_Score : Score_Kind)
      return Rock_Paper_Cissors_Element is
   begin
      if Player_XYZ_Score = Draw then
         return Player_ABC;
      end if;
      case Player_ABC is
         when Rock =>
            case Player_XYZ_Score is
               when Win => return Paper;
               when Lost => return Cissors;
               when others => return Player_ABC;
            end case;
         when Paper =>
            case Player_XYZ_Score is
               when Lost => return Rock;
               when Win => return Cissors;
               when others => return Player_ABC;
            end case;
         when Cissors =>
            case Player_XYZ_Score is
               when Win => return Rock;
               when Lost => return Paper;
               when others => return Player_ABC;
            end case;
      end case;
   end Rock_Paper_Cissors_Rule;

end Rock_Paper_Cissors;
