separate(Puzzle_09)
   procedure Trace_Advice (CrossPoint : Trace_JoinPoint) is
   begin
      if Run_Args.Trace then -- Trace
         case CrossPoint is
            when Show_Input =>
               Displacement_Write (Some_Displacement);
            when Show_Positions =>
               Put (Latin_1.HT);
               Grid_Position_Write (Rope (Head_Knot).Pos);
               Grid_Position_Write (Rope (Tail_Knot).Pos);
               New_Line;
            when Show_Grid =>
               Tail_History_Write (TH);
         end case;
      end if;
   end Trace_Advice;
