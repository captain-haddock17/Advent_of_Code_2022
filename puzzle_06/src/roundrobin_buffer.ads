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

generic
   type Element_Type is (<>);
   type Circular is mod <>;

package RoundRobin_Buffer is

   protected type Circular_Buffer is
      entry Insert (Item : Element_Type);
      function Read (Index : Circular) return Element_Type;
      entry Extract (Item : out Element_Type);
      entry Remove;
      function Count return Natural;
      function Empty return Boolean;
      function Full return Boolean;
   end Circular_Buffer;

private

end RoundRobin_Buffer;
