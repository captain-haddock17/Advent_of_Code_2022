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

   --  Rank of Elfs, with position 1 = Highest Calories value recorded
   subtype Group_Rank is Positive range 1 .. 1;
   type Group_of_Elfs is array (Group_Rank) of Elf;

   Some_Elf : Elf := (Name => 0, Total_Food => 0);
   Elfs_with_most_Food : Group_of_Elfs :=
      (others => (Name => 0, Total_Food => 0));

   Elf_Index : Natural := 0;
   Some_Food : Calories := 0;

   function Elfs_with_Most_Calories (
      Some_Elf : Elf;
      Top_Elfs : Group_of_Elfs)
      return Group_of_Elfs is

      New_Top_Elfs : Group_of_Elfs := Top_Elfs;
   begin
      for One_of in Group_Rank loop
         if Some_Elf.Total_Food > Top_Elfs (One_of).Total_Food then
            --  first retrograde the other elfs in the group
            for Next in reverse One_of + 1 .. Group_Rank'Last loop
               New_Top_Elfs (Next).Total_Food := Top_Elfs (Next - 1).Total_Food;
               New_Top_Elfs (Next).Name := Top_Elfs (Next - 1).Name;
            end loop;
            --  now replace with new value
            New_Top_Elfs (One_of).Total_Food := Some_Elf.Total_Food;
            New_Top_Elfs (One_of).Name := Some_Elf.Name;
         end if;
      end loop;

      return New_Top_Elfs;
   end Elfs_with_Most_Calories;

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
         Elfs_with_most_Food := Elfs_with_Most_Calories (
            Some_Elf => Some_Elf,
            Top_Elfs => Elfs_with_most_Food);
         Next_Elf := True;
         Some_Elf.Total_Food := 0;
      end if;

   end loop;

   New_Line;
   if Elf_Index > 0 then
      Put_Line ("Total Calories of Elf_with_most_Food ="
         & Calories'Image (Elfs_with_most_Food (Group_Rank'First).Total_Food));
   else
      Put_Line ("No Elfs found in file ?!?!");
   end if;

   if Elfs_with_most_Food (Group_Rank'First).Total_Food = 71_502 then
      Put_Line ("Correct answer ;-)");
   end if;
   New_Line;

   exception
      when BAD_ARGUMENTS =>
         null; -- exit program

end Puzzle_01;
