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

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Command_Line; use Command_Line;

package body Filesystems is

      Natural_IO_Length : constant Positive := Integer (0.30103 * (Natural'Size - 1));

   --  -------------------------
   --  Node_record = Node_record
   --  -------------------------
   function "=" (Left, Right : Node_record) return Boolean is
      use Command_Line.OS_File_Name;
   begin
      if Left.Kind /= Right.Kind then
         return False;
      elsif Left.Name = Right.Name then
         return True;
      else
         return False;
      end if;
   end "=";

   --  --------------------
   --  Save_Size_of_Subtree
   --  --------------------
   procedure Save_Size_of_Subtree
     (File_Tree : in out Trees.Tree;
      Parent    : Trees.Cursor)
   is
      SubTotal       : Natural := 0;
      Total          : Natural := 0;
      Current_Cursor : Trees.Cursor;
      Parent_Node    : Node_record;
      Child_Node     : Node_record;

   begin
      for Child_Cursor in File_Tree.Iterate_Children (Parent => Parent) loop
         Child_Node := Trees.Element (Child_Cursor);
         case Child_Node.Kind is
            when File =>
               Total := @ + Child_Node.Size;
            when Dir =>
               Current_Cursor := Child_Cursor;
               if not Child_Node.Valid_SubTree_Size then
                  --  get the size of the subtree
                  SubTotal := Size_of_Subtree
                      (File_Tree => File_Tree,
                       Parent    => Current_Cursor,
                       Max_Size  => Natural'Last);
                  Total := @ + SubTotal;
               else
                  Total := @ + Child_Node.SubTree_Size;
               end if;
               --  Child_Node.Valid_SubTree_Size := True;
               --  Child_Node.SubTree_Size := Total;
               --  File_Tree.Replace_Element (Child_Cursor, Child_Node);
         end case;
      end loop;

      if not Trees.Is_Root (Parent) then
         Parent_Node := Trees.Element (Parent);

         if Run_Args.Trace then -- Trace
            Put (OS_File_Name.To_String (Parent_Node.Name));
         end if;
         case Parent_Node.Kind is
            when File =>
               raise NODE_SHOULD_BE_A_DIR;
            when Dir =>  -- update node info of Dir
               Parent_Node.Valid_SubTree_Size := True;
               Parent_Node.SubTree_Size := Total;
               Trees.Replace_Element (File_Tree, Parent, Parent_Node);
               if Run_Args.Trace then -- Trace
                  Put (Latin_1.HT);
                  Put (Total, Natural_IO_Length);
                  New_Line;
               end if;
         end case;
      end if;
   end Save_Size_of_Subtree;

   --  ---------------
   --  Size_of_Subtree
   --  ---------------
   function Size_of_Subtree
     (File_Tree : Trees.Tree;
      Parent    : Trees.Cursor;
      Max_Size  : Natural)
      return Natural
   is
      SubTotal       : Natural := 0;
      Total          : Natural := 0;
      Current_Cursor : Trees.Cursor;
      Parent_Node    : Node_record;
      Child_Node     : Node_record;
   begin
      for Child_Cursor in File_Tree.Iterate_Children (Parent => Parent) loop
         Child_Node := Trees.Element (Child_Cursor);
         case Child_Node.Kind is
            when File =>
               Total := @ + Child_Node.Size;
            when Dir =>
               if Run_Args.Trace then -- Trace
                  Put (Latin_1.HT);
                  Put (Latin_1.HT);
                  Put (Child_Node.SubTree_Size, Natural_IO_Length);
                  New_Line;
               end if;
               Current_Cursor := Child_Cursor;
               SubTotal       :=
                 Size_of_Subtree
                   (File_Tree => File_Tree,
                    Parent    => Current_Cursor,
                    Max_Size  => Natural'Last);
               Total := @ + SubTotal;
         end case;

      end loop;

      if Total <= Max_Size and not Trees.Is_Root (Parent) then
         Parent_Node := Trees.Element (Parent);

         if Run_Args.Trace then -- Trace
            Put (OS_File_Name.To_String (Parent_Node.Name) & Latin_1.HT);
            Put (Total, Natural_IO_Length);
            New_Line;
         end if;
         return Total;
      elsif Trees.Is_Root (Parent) then
         return Total;
      else
         return 0;
      end if;
   end Size_of_Subtree;

   --  --------------
   --  Sum_of_Subdirs
   --  --------------
   procedure Sum_of_Subdirs
     (File_Tree : Trees.Tree;
      Parent    : Trees.Cursor;
      Max_Size  : Natural;
      Total     : in out Natural)
   is
      SubTotal       : Natural := 0;
      Current_Cursor : Trees.Cursor;
--      Parent_Node    : Node_record;
      Child_Node     : Node_record;
   begin
      for Child_Cursor in File_Tree.Iterate_Children (Parent => Parent) loop
         Child_Node := Trees.Element (Child_Cursor);
         if Child_Node.Kind = Dir then
            Current_Cursor := Child_Cursor;

            if Run_Args.Trace then -- Trace
               Put (OS_File_Name.To_String (Child_Node.Name));
               New_Line;
            end if;
            if Child_Node.Valid_SubTree_Size then 
               if Child_Node.SubTree_Size <= Max_Size then
                  Total := @ + Child_Node.SubTree_Size;

                  if Run_Args.Trace then -- Trace
                     Put (Latin_1.HT);
                     Put (Child_Node.SubTree_Size, Natural_IO_Length);
                     New_Line;
                  end if;
               end if;
            else
               -- raise SUBTREE_SIZE_NOT_VALID;
               null;
            end if;
            Sum_of_Subdirs
                 (File_Tree => File_Tree,
                  Parent    => Current_Cursor,
                  Max_Size  => Max_Size,
                  Total     => SubTotal);
            --  if SubTotal <= Max_Size then
            --     Total := @ + SubTotal;
            --  end if;
         end if;
      end loop;
   end Sum_of_Subdirs;

   function Sum_of_Subdirs
     (File_Tree : Trees.Tree;
      Parent    : Trees.Cursor;
      Max_Size  : Natural)
      return Natural
   is
      GrandTotal : Natural := 0;
   begin
      Sum_of_Subdirs
                 (File_Tree => File_Tree,
                  Parent    => Parent,
                  Max_Size  => Max_Size,
                  Total     => GrandTotal);
      return GrandTotal;
   end Sum_of_Subdirs;

end Filesystems;
