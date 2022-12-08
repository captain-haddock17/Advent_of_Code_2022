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
   function Is_Visible (
         Forest : in out Grid;
         From : Point_of_Vue;
         Tree_Position : Position)
         return Boolean is
      Visibility : Boolean;
   begin
      -- Border of the grid
      if Tree_Position.NS = NS_Dimension'First 
      or Tree_Position.NS = NS_Dimension'Last - 1
      then
         Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
         return True;
      elsif Tree_Position.WE = WE_Dimension'First 
      or Tree_Position.WE = WE_Dimension'Last - 1
      then 
         Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible := True;
         return True;
      else  -- Inside of the grid
         case from is
            when North =>
               Visibility := True;
               for N in NS_Dimension'First .. Tree_Position.NS - 1 loop
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
               for S in reverse Tree_Position.NS + 1 .. Effective_NS_Dim  loop
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
               for E in reverse Tree_Position.WE + 1 .. Effective_WE_Dim loop
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
               for W in WE_Dimension'First .. Tree_Position.WE - 1 loop
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
      end if;
   end Is_Visible;

   --  -----------------------
   --  Mesure_Viewing_Distance
   --  -----------------------
   function Mesure_Viewing_Distance (
         Forest : Grid;
         From : Point_of_Vue;
         Tree_Position : Position)
         return Grid_Distance is
      Distance : Grid_Distance := 0;
   begin
      -- Border of the grid
      if Tree_Position.NS = NS_Dimension'First 
      or Tree_Position.NS = NS_Dimension'Last - 1
      then
         return 0;
      elsif Tree_Position.WE = WE_Dimension'First 
      or Tree_Position.WE = WE_Dimension'Last - 1
      then 
         return 0;
      else  -- Inside of the grid
         case from is
            when North =>
               for N in reverse NS_Dimension'First .. Tree_Position.NS - 1 loop
                  Distance := @ + 1;
                  if Forest (N, Tree_Position.WE).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                     exit;
                  end if;
               end loop;

            when South =>
               for S in Tree_Position.NS + 1 .. Effective_NS_Dim  loop
                  Distance := @ + 1;
                  if Forest (S, Tree_Position.WE).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                     exit;
                  end if;
               end loop;

            when East  =>
               for E in Tree_Position.WE + 1 .. Effective_WE_Dim loop
                  Distance := @ + 1;
                  if Forest (Tree_Position.NS, E).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                     exit;
                  end if;
               end loop;

            when West  =>
               for W in reverse WE_Dimension'First .. Tree_Position.WE - 1 loop
                  Distance := @ + 1;
                  if Forest (Tree_Position.NS, W).Height >= Forest (Tree_Position.NS, Tree_Position.WE).Height then
                     exit;
                  end if;
               end loop;
         end case;
         return Distance;
      end if;
   end Mesure_Viewing_Distance;

   -- --------------------
   --  Check_Visible_Trees
   -- --------------------
   procedure Check_Visible_Trees (Forest : in out Grid) is
      Visible : Boolean;
      Tree_Position : Position;
   begin
      for NS in NS_Dimension'First .. Effective_NS_Dim loop
         for WE in WE_Dimension'First .. Effective_WE_Dim loop
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
      for NS in NS_Dimension'First .. Effective_NS_Dim loop
         for WE in WE_Dimension'First .. Effective_WE_Dim loop
               Tree_Position := (NS, WE);  -- not realy needed; just for better reading
               if Forest (Tree_Position.NS, Tree_Position.WE).Is_Visible then
                  Count := @ + 1;
               end if;
         end loop;
      end loop;
      return Count;
   end Count_Visible_Trees;

   -- ----------------------
   --  Find_Best_Scenic_View
   -- ----------------------
   function Find_Best_Scenic_View (Forest : Grid) return Grid_Distance is
      Highest_Scenic_Score : Natural := 0;
      Distance : Grid_Distance := 0;
      Tree_Position : Position;  -- not realy needed; just for better reading
   begin
      for NS in NS_Dimension'First + 1 .. Effective_NS_Dim - 1 loop
         for WE in WE_Dimension'First + 1 .. Effective_WE_Dim - 1 loop
            Tree_Position := (NS, WE);
            Distance := 1;
            for Look_Towards in Point_of_Vue loop
               Distance := @ * Mesure_Viewing_Distance (Forest, Look_Towards, Tree_Position);
            end loop;
            Highest_Scenic_Score := Natural'Max (Highest_Scenic_Score, Distance);
         end loop;
      end loop;
      return Highest_Scenic_Score;
   end Find_Best_Scenic_View;

end Tree_Grids;
