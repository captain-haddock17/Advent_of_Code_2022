pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-07
--  -------------------------------------------------------------
pragma Ada_2022;

with Command_Line; use Command_Line;

with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Filesystems_IO is

   --  ---------
   --  Load_Tree
   --  ---------
   procedure Load_Tree
     (File_Tree   : in out Trees.Tree;
      Current_Dir : in out Trees.Cursor;
      Data        :        String)
   is
      use Filesystems.Trees;
      use Command_Line.OS_File_Name;

      Detect_Cmd : String (1 .. Prefix_Length);
      End_Num    : Natural;

      File_Size      : Natural;
      Some_Node_Name : Node_Name;
      Some_Node      : Node_record;
      Some_Cursor    : Cursor := No_Element;
   begin

      if Data'Length >= Prefix_Length then
         Detect_Cmd := Data (1 .. Prefix_Length);

         if -- cd
         Detect_Cmd = cmd_cd (1 .. Prefix_Length) then
            if -- cd /
            Data'Length >= cmd_cd_Root'Length
              and then Data (1 .. cmd_cd_Root'Length) = cmd_cd_Root
            then
               Some_Node_Name := OS_File_Name.To_Bounded_String ("/");
               Some_Node      := (Kind => Dir, Name => Some_Node_Name, Valid_SubTree_Size => False, SubTree_Size => 0);
               File_Tree.Append_Child
                 (Parent => Root (File_Tree), New_Item => Some_Node);
               Current_Dir := First_Child (Root (File_Tree));

               if Run_Args.Trace then -- Trace
                  Put_Line ("mkdir root; cd root");
               end if;

            elsif -- cd ..
            Data'Length >= cmd_cd_Back'Length
              and then Data (1 .. cmd_cd_Back'Length) = cmd_cd_Back
            then
               Current_Dir := Parent (Current_Dir);

               if Run_Args.Trace then -- Trace
                  Put_Line (cmd_cd_Back (3 .. cmd_cd_Back'Length));
               end if;

            else -- cd xxxx
               Some_Node_Name :=
                 OS_File_Name.To_Bounded_String
                   (Data (cmd_cd'Length + 1 .. Data'Length));
               Some_Node := (Kind => Dir, Name => Some_Node_Name, Valid_SubTree_Size => False, SubTree_Size => 0);

               if Run_Args.Trace then -- Trace
                  Put_Line ("cd " & To_String (Some_Node.Name));
               end if;

               Some_Cursor := No_Element;
               for Child_Cursor in File_Tree.Iterate_Children
                 (Parent => Current_Dir)
               loop
                  if Element (Child_Cursor) = Some_Node then
                     Some_Cursor := Child_Cursor;
                     exit;
                  end if;
               end loop;
               if Some_Cursor /= No_Element then
                  Current_Dir := Some_Cursor;
               else
                  raise NON_EXISTANT_SUBDIR;
               end if;

            end if;

         elsif -- ls
         Detect_Cmd = cmd_ls (1 .. Prefix_Length) then
            null;

         elsif -- dir
         Detect_Cmd = cmd_dir (1 .. Prefix_Length) then

            Some_Node_Name :=
              OS_File_Name.To_Bounded_String
                (Data (cmd_dir'Length + 1 .. Data'Length));
            Some_Node := (Kind => Dir, Name => Some_Node_Name, Valid_SubTree_Size => False, SubTree_Size => 0);

            File_Tree.Append_Child
              (Parent => Current_Dir, New_Item => Some_Node);

            if Run_Args.Trace then -- Trace
               Put_Line ("mkdir " & To_String (Some_Node.Name));
            end if;

         else -- file
            Get (From => Data, Item => File_Size, Last => End_Num);
            Some_Node_Name :=
              OS_File_Name.To_Bounded_String
                (Data (End_Num + 2 .. Data'Length));

            Some_Node :=
              (Kind => File, Name => Some_Node_Name, Size => File_Size);
            File_Tree.Append_Child
              (Parent => Current_Dir, New_Item => Some_Node);

            if Run_Args.Trace then -- Trace
               Put_Line
                 ("dd if=/dev/urandom of=" & OS_File_Name.To_String (Some_Node_Name) & " bs=" &
                  Trim(File_Size'Image, Left) & " count=1");
            end if;

         end if;
      end if;
   end Load_Tree;

end Filesystems_IO;
