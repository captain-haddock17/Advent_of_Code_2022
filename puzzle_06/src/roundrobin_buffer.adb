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

package body RoundRobin_Buffer is

   Capacity    : constant Positive := Natural (Circular'Last) + 1;
   Counter     : Natural range 0 .. Capacity;
   First, Last : Circular          := 0;

   type Buffer_array is array (Circular) of Element_Type;
   Buffer : Buffer_array;

   --  ======
   --  Buffer
   --  ======
   protected body Circular_Buffer is

      --  ------
      --  Insert
      --  ------
      entry Insert (Item : Element_Type) when not Full is
      begin
         Last          := @ + 1;
         Buffer (Last) := Item;
         Counter       := @ + 1;
      end Insert;

      --  ----
      --  Read
      --  ----
      function Read (Index : Circular) return Element_Type is
      begin
         return Buffer (First + Index + 1);
      end Read;

      --  -------
      --  Extract
      --  -------
      entry Extract (Item : out Element_Type) when not Empty is
      begin
         Item    := Buffer (First);
         First   := @ + 1;
         Counter := @ - 1;
      end Extract;

      --  ------
      --  Remove
      --  ------
      entry Remove when not Empty is
      begin
         First   := @ + 1;
         Counter := @ - 1;
      end Remove;

      --  -----
      --  Count
      --  -----
      function Count return Natural is
      begin
         return Counter;
      end Count;

      --  -----
      --  Empty
      --  -----
      function Empty return Boolean is
      begin
         if Counter = 0 then
            return True;
         else
            return False;
         end if;
      end Empty;

      --  ----
      --  Full
      --  ----
      function Full return Boolean is
      begin
         if Counter = Capacity then
            return True;
         else
            return False;
         end if;
      end Full;

   end Circular_Buffer;

end RoundRobin_Buffer;
