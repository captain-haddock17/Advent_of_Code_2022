pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-08
--  -------------------------------------------------------------
pragma Ada_2022;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Command_Line; use Command_Line;

package body Tree_Grids is

   -- -----------------------
   --  Set_Trees_to_Invisible
   -- -----------------------
   procedure Set_Trees_to_Invisible (Forest : in out Grid) is
   begin
      for NS in NS_Dimension'First .. Effective_NS_Dim loop
         for WE in WE_Dimension'First .. Effective_WE_Dim loop
            Forest (NS, WE).Is_Visible := False;
         end loop;
      end loop;
   end Set_Trees_to_Invisible;

   --  ----------
   --  Is_Visible
   --  ----------
   function Is_Visible (Forest : in out Grid; From : Point_of_Vue; Tree_Position : Position) return Boolean is
      Visibility : Boolean;
   begin
      if Tree_Position.NS = NS_Dimension'First + 1 or Tree_Position.NS = NS_Dimension'Last - 1 then 
         Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
         return True;
      end if;

      if Tree_Position.WE = WE_Dimension'First + 1 or Tree_Position.WE = WE_Dimension'Last - 1 then 
         Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
         return True;
      end if;

      case from is
         when North =>
            Visibility := True;
            for N in NS_Dimension'First + 1 .. Tree_Position.NS - 1 loop
               if Forest (N, Tree_Position.WE).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                  Visibility := False;
                  exit;
               end if;
            end loop;
            if Visibility then
               Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
            end if;

         when South =>
            Visibility := True;
            for S in reverse Tree_Position.NS + 1 .. Effective_NS_Dim - 1  loop
               if Forest (S, Tree_Position.WE).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                  Visibility := False;
                  exit;
               end if;
            end loop;
            if Visibility then
               Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
            end if;

         when East  =>
            Visibility := True;
            for E in reverse Tree_Position.WE + 1 .. Effective_WE_Dim - 1 loop
               if Forest (Tree_Position.NS, E).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                  Visibility := False;
                  exit;
               end if;
            end loop;
            if Visibility then
               Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
            end if;

         when West  =>
            Visibility := True;
            for W in WE_Dimension'First + 1 .. Tree_Position.WE - 1 loop
               if Forest (Tree_Position.NS, W).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                  Visibility := False;
                  exit;
               end if;
            end loop;
            if Visibility then
               Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
            end if;
      end case;

      return Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible;
   end Is_Visible;

   -- --------------------
   --  Check_Visible_Trees
   -- --------------------
   procedure Check_Visible_Trees (Forest : in out Grid) is
      Visible : Boolean;
      Tree_Position : Position;
   begin
      for NS in NS_Dimension'First + 1 .. Effective_NS_Dim - 1 loop
         for WE in WE_Dimension'First + 1 .. Effective_WE_Dim - 1 loop
            Tree_Position := (NS, WE);
            for Vue_From in Point_of_Vue loop
               Visible := Is_Visible (Forest, Vue_From, Tree_Position);
               if Visible then
                  exit;
               end if;
            end loop;
         end loop;
      end loop;
   end Check_Visible_Trees;

   -- --------------------
   --  Count_Visible_Trees
   -- --------------------
   function Count_Visible_Trees (Forest : Grid) return Natural is
      Count : Natural := 0;
      Tree_Position : Position;  -- not realy needed; just for better reading
   begin
      for NS in NS_Dimension'First + 1 .. Effective_NS_Dim - 1 loop
         for WE in WE_Dimension'First + 1 .. Effective_WE_Dim - 1 loop
               Tree_Position := (NS, WE);  -- not realy needed; just for better reading
               if Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible then
                  Count := @ + 1;
               end if;
         end loop;
      end loop;
      return Count;
   end Count_Visible_Trees;


end Tree_Grids;
