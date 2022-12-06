pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-06
--  -------------------------------------------------------------
pragma Ada_2022;

with RoundRobin_Buffer;

generic

   type Marker_Index is mod <>;

package Marker is

   Marker_Length : Positive := Integer (Marker_Index'Last) + 1;

   package Marker_Buffer is new RoundRobin_Buffer
     (Element_Type => Character, Circular => Marker_Index);

   procedure Analyse_Buffer (
         Buffer : in out Marker_Buffer.Circular_Buffer;
         Data   : Character;
         Index : Natural;
         Marker_Present : in out Boolean;
         Starting_at : in out Natural);

   function Marker_Found
     (Buffer : Marker_Buffer.Circular_Buffer) return Boolean;

private

end Marker;
