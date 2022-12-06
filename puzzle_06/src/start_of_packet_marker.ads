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

package Start_of_Packet_Marker is

   Start_of_Packet_Marker_Length : constant Positive := 4;
   type Start_of_Packet_Marker_Index is mod Start_of_Packet_Marker_Length;

   package Start_of_Packet_Marker_Buffer is new RoundRobin_Buffer
     (Element_Type => Character, Circular => Start_of_Packet_Marker_Index);

   function Start_of_Packet_Marker_Found (Buffer : Start_of_Packet_Marker_Buffer.Circular_Buffer) return Boolean;

private

end Start_of_Packet_Marker;
