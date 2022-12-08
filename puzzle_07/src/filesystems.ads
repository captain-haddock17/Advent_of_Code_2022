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

with Command_Line;

with Ada.Containers.Multiway_Trees;

package Filesystems is

   subtype Node_Name is Command_Line.OS_File_Name.Bounded_String;

   type Node_Kind is (File, Dir);

   type Node_record (Kind : Node_Kind := Dir) is record
      Name : Node_Name;
      case Kind is
         when File =>
            Size : Natural := 0;
         when Dir =>
            Valid_SubTree_Size : Boolean := False;
            --  case Valid_SubTree_Size is
            --     when True => 
            SubTree_Size : Natural := 0;
            --     when False => null;
            --  end case;
      end case;
   end record;

   NON_EXISTANT_SUBDIR    : exception;
   NODE_SHOULD_BE_A_DIR   : exception;
   SUBTREE_SIZE_NOT_VALID : exception;

   overriding function "=" (Left, Right : Node_record) return Boolean;

   package Trees is new Ada.Containers.Multiway_Trees
     (Element_Type => Node_record, "=" => "=");

   procedure Save_Size_of_Subtree
     (File_Tree : in out Trees.Tree;
      Parent    : Trees.Cursor);

   function Size_of_Subtree
     (File_Tree : Trees.Tree;
      Parent    : Trees.Cursor;
      Max_Size  : Natural)
      return Natural;

   function Sum_of_Subdirs
     (File_Tree : Trees.Tree;
      Parent    : Trees.Cursor;
      Max_Size  : Natural)
      return Natural;

private

end Filesystems;
