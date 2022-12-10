pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-09
--  -------------------------------------------------------------
pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
--  with Ada.Characters.Latin_1; use Ada.Characters;

package body Ropes.Moves is

   --  -----------
   --  Read_Record
   --  -----------
   procedure Read_Record (
      Stream : not null access Root_Stream_Type'Class;
      Item   : out Displacement)
   is
      C : Character;
   begin
      Character'Read (Stream, C);
      Item.Dir := Direction'Enum_Val (Character'Pos(C));
      Get (Item.Dist);
      Skip_Line;
   end Read_Record;

   --  ------------
   --  Write_Record
   --  ------------
   pragma Warnings (Off, "formal parameter ""Stream"" is not referenced");
   procedure Write_Record (   -- for the purpose of tracing
      Stream : not null access Root_Stream_Type'Class;
      Item   : Displacement)
   is
   begin
      Put (Item.Dir'Image);
      Put (Item.Dist'Image);
   end Write_Record;
   pragma Warnings (On, "formal parameter ""Stream"" is not referenced");

   --  -----------------
   --  New_Head_Position
   --  -----------------
   function New_Head_Position (Head_From : Grid_Position; Move : Displacement) return Grid_Position
   is
   begin
      case Move.Dir is
         when Up =>
            return (Head_From.X, Head_From.Y + Y_Dimension(Move.Dist));
         when Down =>
            return (Head_From.X, Head_From.Y - Y_Dimension(Move.Dist));
         when Left =>
            return (Head_From.X - X_Dimension(Move.Dist), Head_From.Y);
         when Right =>
            return (Head_From.X + X_Dimension(Move.Dist), Head_From.Y);
      end case;
   end New_Head_Position;

   --  -----------------
   --  New_Knot_Position
   --  -----------------
   function New_Knot_Position (
         This_Knot : Knot_record;
         Tail_Pos, Head_From : Grid_Position;  
         Move : Displacement;
         History : in out Tail_History)
         return Grid_Position
   is
      New_Tail : Grid_Position;
      Head_To : Grid_Position;
      Delta_X : X_Dimension;
      Delta_Y : Y_Dimension;
   begin
      Head_To := New_Head_Position (Head_From, Move);
      Delta_X := Tail_Pos.X - Head_From.X;
      Delta_Y := Tail_Pos.Y - Head_From.Y;

      New_Tail := Tail_Pos;
      case Move.Dir is
         when Up =>
            if (Move.Dist = 1 and then Delta_Y >= 0) 
            or (Move.Dist = 2 and then Delta_Y = 1)
            then
               null;
            else  -- Delta_Y in -1
               New_Tail.X := Head_To.X;
               New_Tail.Y := Head_To.Y - 1 ;
               for D_Y in 1 .. Y_Dimension (Move.Dist - 1) - Delta_Y loop
                  if This_Knot.ID = Tail_Knot then
                     Store_History (History, (Head_To.X, Head_To.Y - D_Y));
                  end if;
               end loop;
            end if;
         when Right =>
            if (Move.Dist = 1 and then Delta_X >= 0)
            or (Move.Dist = 2 and then Delta_X = 1)
            then
               null;
            else -- Delta_X in -1
               New_Tail.X := Head_To.X - 1;
               New_Tail.Y := Head_To.Y;
               for D_X in 1 .. X_Dimension (Move.Dist - 1) - Delta_X loop
                  if This_Knot.ID = Tail_Knot then
                     Store_History (History, (Head_To.X - D_X, Head_To.Y));
                  end if;
               end loop;
            end if;
         when Down =>
            if (Move.Dist = 1 and then Delta_Y <= 0)
            or (Move.Dist = 2 and then Delta_Y = -1)
            then
               null;
            else -- Delta_Y in 1
               New_Tail.Y := Head_To.Y + 1;
               New_Tail.X := Head_To.X;
              for D_Y in 1 .. Y_Dimension (Move.Dist - 1) + Delta_Y loop
                  if This_Knot.ID = Tail_Knot then
                     Store_History (History, (Head_To.X, Head_To.Y + D_Y));
                  end if;
               end loop;
            end if;
         when Left =>
            if (Move.Dist = 1 and then Delta_X <= 0)
            or (Move.Dist = 2 and then Delta_X = -1)
            then
               null;
            else -- Delta_X in  1
               New_Tail.X := Head_To.X + 1;
               New_Tail.Y := Head_To.Y;
               for D_X in 1 .. X_Dimension (Move.Dist - 1) + Delta_X loop
                  if This_Knot.ID = Tail_Knot then
                     Store_History (History, (Head_To.X + D_X, Head_To.Y));
                  end if;
               end loop;
            end if;
      end case;

      return New_Tail;

   end New_Knot_Position;

   --  -----------------
   --  New_Tail_Position
   --  -----------------
   function New_Tail_Position (
         Tail_Pos, Head_From : Grid_Position;  
         Move : Displacement;
         History : in out Tail_History)
         return Grid_Position
   is
      New_Tail : Grid_Position;
      Head_To : Grid_Position;
      Delta_X : X_Dimension;
      Delta_Y : Y_Dimension;
   begin
      Head_To := New_Head_Position (Head_From, Move);
      Delta_X := Tail_Pos.X - Head_From.X;
      Delta_Y := Tail_Pos.Y - Head_From.Y;

      New_Tail := Tail_Pos;
      case Move.Dir is
         when Up =>
            if (Move.Dist = 1 and then Delta_Y >= 0) 
            or (Move.Dist = 2 and then Delta_Y = 1)
            then
               null;
            else  -- Delta_Y in -1
               New_Tail.X := Head_To.X;
               New_Tail.Y := Head_To.Y - 1 ;
               for D_Y in 1 .. Y_Dimension (Move.Dist - 1) - Delta_Y loop
                  Store_History (History, (Head_To.X, Head_To.Y - D_Y));
               end loop;
            end if;
         when Right =>
            if (Move.Dist = 1 and then Delta_X >= 0)
            or (Move.Dist = 2 and then Delta_X = 1)
            then
               null;
            else -- Delta_X in -1
               New_Tail.X := Head_To.X - 1;
               New_Tail.Y := Head_To.Y;
               for D_X in 1 .. X_Dimension (Move.Dist - 1) - Delta_X loop
                  Store_History (History, (Head_To.X - D_X, Head_To.Y));
               end loop;
            end if;
         when Down =>
            if (Move.Dist = 1 and then Delta_Y <= 0)
            or (Move.Dist = 2 and then Delta_Y = -1)
            then
               null;
            else -- Delta_Y in 1
               New_Tail.Y := Head_To.Y + 1;
               New_Tail.X := Head_To.X;
              for D_Y in 1 .. Y_Dimension (Move.Dist - 1) + Delta_Y loop
                  Store_History (History, (Head_To.X, Head_To.Y + D_Y));
               end loop;
            end if;
         when Left =>
            if (Move.Dist = 1 and then Delta_X <= 0)
            or (Move.Dist = 2 and then Delta_X = -1)
            then
               null;
            else -- Delta_X in  1
               New_Tail.X := Head_To.X + 1;
               New_Tail.Y := Head_To.Y;
               for D_X in 1 .. X_Dimension (Move.Dist - 1) + Delta_X loop
                  Store_History (History, (Head_To.X + D_X, Head_To.Y));
               end loop;
            end if;
      end case;

      return New_Tail;

   end New_Tail_Position;

end Ropes.Moves;
