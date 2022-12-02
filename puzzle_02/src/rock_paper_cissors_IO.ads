--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-02
--  -------------------------------------------------------------
pragma Ada_2022;
pragma Style_Checks ("M120");

with Rock_Paper_Cissors;
use Rock_Paper_Cissors;

package Rock_Paper_Cissors_IO is
--   pragma Preelaborate;

   --  ====================
   --  Elements of the game
   --  ====================
   --  type Elf_Play_Element is limited private;
   --  type My_Play_Element is private;

   --  type Elf_RPC_encoding_array is limited private;
   --  type My_RPC_encoding_array is limited private;

   type Elf_Play_Element is (A, B, C);
   for Elf_Play_Element use (
      A => Character'Pos('A'),
      B => Character'Pos('B'),
      C => Character'Pos('C'));

   type Elf_RPC_encoding_array is array (Elf_Play_Element) of Rock_Paper_Cissors_Element;
   Elf_RPC_encoding : constant Elf_RPC_encoding_array := 
      (A => Rock, B => Paper, C => Cissors);

   type My_Play_Element is (X, Y, Z);
   for  My_Play_Element use (
      X => Character'Pos('X'),
      Y => Character'Pos('Y'),
      Z => Character'Pos('Z'));

   type My_RPC_encoding_array is array (My_Play_Element) of Rock_Paper_Cissors_Element;
   My_RPC_encoding : constant My_RPC_encoding_array := 
      (X => Rock, Y => Paper, Z => Cissors);

   Elf_Play_Data_Position : constant Positive := 1;
   My_Play_Data_Position : constant Positive := 3;

   --  ===================
   --  Handling of records
   --  ===================
   subtype Round_Record is String (1 .. 3);

   generic 
      type Play_Element is (<>); 
      type RPC_Encoding_array is array (Play_Element) of Rock_Paper_Cissors_Element;
      RPC_Encoding : RPC_Encoding_array;
      Play_Data_Position : Positive;
   function Read_Play (
      Data : Round_Record) 
      return Rock_Paper_Cissors_Element;

private

end Rock_Paper_Cissors_IO;
