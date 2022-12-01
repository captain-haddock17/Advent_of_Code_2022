--  -------------------------------------------------------------
--  Author : William J. FRANCK
--  e-Mail : william@sterna.io
--
--  Initial creation date : 2022-12-01
--  -------------------------------------------------------------
--  License : CC-BY-SA
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------

with Command_Line;
use Command_Line;

with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Bounded;

with Ada.Text_IO;
use Ada.Text_IO;
use Ada;

with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure Puzzle_01 is

   subtype Calories is Natural;

   type Elf is record
      Name : Natural;
      Total_Food : Calories;
   end record;

   Elf_Index : Natural := 0;
   Some_Food : Calories := 0;
   Some_Elf, Elf_with_most_Food : Elf := (Name => 0, Total_Food => 0);

   --  ----------------------------
   --  File and Run-Time Parameters
   --  ----------------------------
   Data_File   : Ada.Text_IO.File_Type;

   package Data_Strings is
      new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 10);
   use Data_Strings;
   Some_Data : Data_Strings.Bounded_String;

   Last_Character_Index : Positive;
   Next_Elf : Boolean := True;

   Run_Args    : Command_Line.Program_args;

begin
   --  get the command lien arguments
   Command_Line.Get_Args (Args => Run_Args);

   --  Open and read the file
   Open
      (File => Data_File,
       Mode => In_File,
       Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

   --   Data_Stream := Stream (Data_File);

   while not End_Of_File (Data_File) loop

      Some_Data := Data_Strings.To_Bounded_String (
         Get_Line (File => Data_File));

      if Length (Some_Data) > 0 then
         if Next_Elf then
            Elf_Index := @ + 1;
            Next_Elf := False;
         end if;

         Get (From => Data_Strings.To_String (Some_Data),
              Item => Some_Food,
              Last => Last_Character_Index);

         --  Put_Line (Calories'Image (Some_Food));
         --  Some_Elf.Name := Elf_Index;
         Some_Elf.Total_Food := @ + Some_Food;
      else
         if Some_Elf.Total_Food > Elf_with_most_Food.Total_Food then
            Elf_with_most_Food.Total_Food := Some_Elf.Total_Food;
            Elf_with_most_Food.Name := Elf_Index;
         end if;
         Next_Elf := True;
         Some_Elf.Total_Food := 0;
      end if;

   end loop;

   New_Line;
   if Elf_Index > 0 then
      Put_Line ("Total Calories of Elf_with_most_Food ="
         & Calories'Image (Elf_with_most_Food.Total_Food));
   else
      Put_Line ("No Elfs found in file ?!?!");
   end if;

   if Elf_with_most_Food.Total_Food = 71_502 then
      Put_Line ("Correct answer ;-)");
   end if;
   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_01;
