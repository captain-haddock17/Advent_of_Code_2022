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

with Filesystems; use Filesystems;

package Filesystems_IO is

   cmd_cd      : constant String := "$ cd ";
   cmd_cd_Root : constant String := "$ cd /";
   cmd_cd_Back : constant String := "$ cd ..";
   cmd_ls      : constant String := "$ ls";
   cmd_dir     : constant String := "dir ";

   Prefix_Length : constant Positive := 4;

   procedure Load_Tree
     (File_Tree   : in out Trees.Tree; 
      Current_Dir : in out Trees.Cursor;
      Data        :        String);

private

end Filesystems_IO;
