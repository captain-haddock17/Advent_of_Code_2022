pragma Style_Checks ("M120");
--  -------------------------------------------------------------
--  SPDX-License-Identifier: CC-BY-SA-4.0
--  SPDX-FileCopyrightText: Copyright 2022 William J. FRANCK (william@sterna.io)
--  SPDX-Creator: William J. FRANCK (william@sterna.io)
--  Ref: https://creativecommons.org/licenses/by-sa/4.0/legalcode
--  -------------------------------------------------------------
--  Initial creation date : 2022-12-05
--  -------------------------------------------------------------
pragma Ada_2022;

with Piles_of_Crates;
use Piles_of_Crates;

with Command_Line;
use Command_Line;

with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

with Ada.Text_IO;
use  Ada.Text_IO;

package body Crane_IO is

   function Read_Action (Data : String) return Order is
      Some_Order : Order := (0, Pile_ID_range'First, Pile_ID_range'First);

      Data_Index : Natural := 1;
      Last_Index : Natural;
      move_str : constant String := "move";
      from_str : constant String := " from";
      to_str : constant String := " to";

   begin
      if Data'Length > 0
      --  "move"
      and then Data (Data_Index .. move_str'Length) = move_str
      then
         --  Quantity value
         Data_Index := @ + move_str'Length;
         Get (From => Data (Data_Index .. Data'Length),
              Item => Some_Order.Quantity,
              Last => Last_Index);
         --  "from"
         Data_Index := Last_Index + 1;
         if Data (Data_Index .. Data_Index + from_str'Length - 1) = from_str then
            --  Pile #1
            Data_Index := @ + from_str'Length + 1;
            Get (From => Data (Data_Index .. Data'Length),
                 Item => Some_Order.From,
                 Last => Last_Index);
            --  "to"
            Data_Index := Last_Index + 1;
            if Data (Data_Index .. Data_Index + to_str'Length - 1) = to_str then
               --  Pile #2
               Data_Index := @ + to_str'Length + 1;
               Get (From => Data (Data_Index .. Data'Length),
                    Item => Some_Order.To,
                    Last => Data_Index);
            else
               Put_Line (Standard_Error, "*** Error on "& to_str);
               Put_Line (Standard_Error, Data (Data_Index .. Data'Length));
            end if;
         else
               Put_Line (Standard_Error, "*** Error on "& from_str);
               Put_Line (Standard_Error, Data (Data_Index .. Data'Length));
         end if;
      else
         Put_Line (Standard_Error, "*** Error on "& move_str);
         Put_Line (Standard_Error, Data (Data_Index .. Data'Length));
      end if;

      if Run_Args.Trace then -- Trace
         Put ("(" & Some_Order.Quantity'Image & ") ");
         Put (Some_Order.From'Image);
         Put (" -->");
         Put (Some_Order.To'Image);
         new_Line;
      end if;

      return Some_Order;
   end Read_Action;

end Crane_IO;
